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
    attr_reader :bucket

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
              documents_counter = client_or_work.documents["document_count"].to_i
              save_name = client_or_work.name.downcase.gsub(/\s+/, "") + "_id(#{client_or_work.id})_doc#{documents_counter}"
          elsif client_or_work.class.name == "Work"
            save_name = client_or_work.subject + "_id(#{client_or_work.id})"
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
            save_folder = "Client"
            #save_folder = client_or_work.name.downcase.gsub(/\s+/, "") + "_id(#{client_or_work.id})"
          elsif client_or_work.class.name == "Work"
            save_folder = "Work"
            #save_folder = client_or_work.subject + "_id(#{client_or_work.id})"
          else
          end
        end

        # --------------------------------------
        # save_folder
        # simple method to deal with naming
        # default: client first name - id: 
        # --------------------------------------

        # --------------------------------------
        # aws_metadata
        # create an object with important fields
        # to be attached to the document
        # --------------------------------------
        
        def aws_save_client(client, document, bucket='prcstudio3herokubucket', meta)
          aws_configurations_resources                                                    # Start AWS Resources 
          aws_doc(client, document)                                                       # Continue Resources and Gets a Template                                     
          doc = Docx::Document.open(@aws_body)                                            # Open and return a template to work with   
          doc_templated = Templater::TemplaterService.replacer(client, doc)               # Runs the Templater/Replacer Service
          name = save_name(client)                                                        # Configures filename              
          folder = save_folder(client)                                                    # Configures foldername
          #raise
          save_to_rails = doc_templated.save(Rails.root.join("tmp/#{name}.docx").to_s)    # Save file to Rails tmp file 
          file_to_upload = "tmp/#{name}.docx"                                             # Find file into rails tmp
          begin
          @s3.bucket(bucket).object("tmp/#{folder}/#{name}.docx").upload_file(file_to_upload, metadata: meta) do |response| # Upload document with metadata 
            etag = response.etag                                                          # check response 
            if etag = true                                                                # check if response exist    
              puts "Documento Gerado com Sucesso"                                         # message 
            end 
          end 
          rescue Aws::Errors::ServiceError => e
            puts "Couldn't upload file #{file_path} to #{@object.key}. Here's why: #{e.message}" # error rescue
            false
                                                                                          # Todo: Check if @s3 is really need
                                                                                          # .object => Place to be uploaded
          end                                                                             # upload file => file to puload 
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
          @s3.bucket(bucket).object("#{folder}/#{name}.docx").upload_file(file_to_upload)
        end 

        # --------------------------------------
        # aws_save_client is generator for client/procuration (procuracao simples)
        # aws_save_work is the same, but for wdos work/wdocs (work documents)
        # TODO: work metadata
        # TODO: work rescue erro message
        # TODO: work response
        # --------------------------------------

    
        def list_objects(bucket)
          aws_configurations_client
          aws_configurations_resources
          buck = @s3.bucket(bucket)
          @aws_client.list_objects({bucket:"prcstudio3herokubucket", prefix: "tmp/Client/"})
        end

        # --------------------------------------
        # list_objects is for finding the objects inside a bucket 
        # this will help in the show for listing the generated documents 
        # --------------------------------------

        def get_object_head(bucket, key)
          params = {
            bucket: bucket,
            key: key
          }
          @aws_client.head_object(options = params)
        end

        # --------------------------------------
        # get_object_head is for finding 
        # especific objects into bucket 
        # but to use only the metadata (head)
        # this will help in the show for listing the generated documents 
        # --------------------------------------

      # KEEP ENDS # 
    end
  
  end
  
end