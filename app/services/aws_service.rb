module AwsService

# --------------------------------------
# AwsService 
# This is the place for dealing with AwsS3
# --------------------------------------

    class AwsService
    require 'aws-sdk-s3'
    require 'time'
    require 'docx'
    require 'json'
    require 'rails-i18n'

      class << self    

        def aws_configurations_client
          aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
            ENV['AWS_ID'],
            ENV['AWS_SECRET_KEY']
            )})
            @aws_client = Aws::S3::Client.new
            @aws_client
        end
       
        # --------------------------------------
        # aws_configurations_client 
        # create a client instance into amazon S3
        # --------------------------------------

        def aws_configurations_resources
          @s3 = Aws::S3::Resource.new(region: 'us-west-2')
          @s3 
        end

        # --------------------------------------
        # aws_configurations_client 
        # to return the resource into the designed region 
        # --------------------------------------

        def aws_doc(bucket="prcstudio3herokubucket", client, document)
          aws_configurations_client
          aws_doc = @aws_client.get_object(bucket:bucket, key:"base/#{document}.docx")
          @aws_body = aws_doc.body
          @doc = Docx::Document.open(@aws_body)
          @doc
        end
        
        # --------------------------------------
        # aws_doc
        # find the template and return using DOCX open
        # to run the substitutions after opened
        # --------------------------------------
        
        def save_name(client_or_work)
          if client_or_work.class.name == "Client"
            save_name = client_or_work.name.downcase.gsub(/\s+/, "") + "_id(#{client_or_work.id})"
          elsif client_or_work.class.name == "Work"
            save_name = client_or_work.jubject + "_id(#{client_or_work.id})"
          else
          end
        end

        # --------------------------------------
        # save_name
        # simple method to deal with naming
        # default: client first name - id: 
        # --------------------------------------

        def save_folder(client_or_work)
          if client_or_work.class.name == "Client"
            save_folder = client_or_work.name.downcase.gsub(/\s+/, "") + "_id(#{client_or_work.id})"
          elsif client_or_work.class.name == "Work"
            save_folder = client_or_work.jubject + "_id(#{client_or_work.id})"
          else
          end
        end

        # --------------------------------------
        # save_folder
        # simple method to deal with naming
        # default: client first name - id: 
        # --------------------------------------

        def aws_metadata
          metadata = {
          :user_id => "#{current_user.id}"
          }
        end

        # --------------------------------------
        # aws_metadata
        # create an object with important fields
        # to be attached to the document
        # --------------------------------------
        
        def aws_save_client(client, document, bucket='prcstudio3herokubucket')
          aws_configurations_resources                                                    # Start AWS Resources 
          aws_doc(client, document)                                                       # Continue Resources and Gets a Template                                     
          doc = Docx::Document.open(@aws_body)                                            # Open and return a template to work with   
          doc_templated = Templater::TemplaterService.replacer(client, doc)               # Runs the Templater/Replacer Service
          name = save_name(client)                                                        # Configures filename              
          folder = save_folder(client)                                                    # Configures foldername
          save_to_rails = doc_templated.save(Rails.root.join("tmp/#{name}.docx").to_s)    # Save file to Rails tmp file 
          file_to_upload = "tmp/#{name}.docx"                                             # Find file into rails tmp
          @s3.bucket(bucket).object("#{folder}/#{name}.docx").upload_file(file_to_upload, metadata: aws_metadata) 
                                                                                          # Todo: Check if @s3 is really need
                                                                                          # .object => Place to be uploaded
                                                                                          # upload file => file to puload 
        end

        def aws_save_work(work, document, bucket='prcstudio3herokubucket')
          aws_configurations_resources
          aws_doc(work, document)
          doc = Docx::Document.open(@aws_body)              
          doc_templated = TemplaterWork::TemplaterWorkService.replacer_work(work, doc)
          name = save_name(work)
          folder = save_folder(work)
          save_to_rails = doc_templated.save(Rails.root.join("tmp/#{name}.docx").to_s)
          file_to_upload = "tmp/#{name}.docx"
          @s3.bucket(bucket).object("#{folder}/#{name}.docx").upload_file(file_to_upload, metadata: aws_metadata)
        end 
    

      # KEEP # 
    end
  
  end
  
end