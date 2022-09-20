module AwsService

    class AwsService
    require 'aws-sdk-s3'
    require 'time'

      class << self    

        def aws_configurations
          aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
              ENV['AWS_ID'],
              ENV['AWS_SECRET_KEY']
              )})
          @aws_client = Aws::S3::Client.new
          # RETORNAR 2 Valores --- Dividir em 2 Métodos
          @s3 = Aws::S3::Resource.new(region: 'us-west-2')
          @aws_client
        end      

        # Select Bucket and Doc Base 
        def aws_bucket(bucket, client, document) 
          aws_doc = @aws_client.get_object(bucket:"prcstudio3herokubucket", key:"base/#{document}.docx")
          aws_body = aws_doc.body
        end

        def aws_bcd(bucket="prcstudio3herokubucket", client_id, document) 
          aws_doc = @aws_client.get_object(bucket:"#{bucket}", key:"base/client_#{client_id}/#{document}.docx")
          aws_body = aws_doc.body
        end

        #def list_files()
       # end

        # def aws_save_and_upload
        #   bucket = 'prcstudio3herokubucket'
        #   nome_correto = client[:name].downcase.gsub(/\s+/, "")
        #   ch_save = doc.save(Rails.root.join("tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
        #   ch_file = "tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx"
        #   obj = @s3.bucket(bucket).object(ch_file)
        #   client.documents = metadata
        #   client.save
        #   obj.upload_file(ch_file, metadata: metadata)               
        # end

        # def aws_meta
        #   metadata = {
        #         :document_key => ch_file,
        #         :document_name => "procuracao_simples-#{nome_correto}_#{client.id}.docx",
        #         :client_id => "#{client.id}",
        #         :"user_id" => "#{current_user.id}",
        #         :document_type => document.to_s,
        #         :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
        #         :user => "#{current_user.id}"
        #          }
        # end
    #backup
    #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
    #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
    #obj = @s3.bucket(bucket).object(ch_file)
    #backup

    

        # def aws_list
        # end

        # def aws_json
        # end
  
 
        
    end
  
  end
  
end