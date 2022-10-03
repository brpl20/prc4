module AwsService

    class AwsService
    require 'aws-sdk-s3'
    require 'time'
    require 'docx'
    require 'json'
    require 'rails-i18n'

      class << self    

        # Aws Configuração do Client 
        def aws_configurations_client
          aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
              ENV['AWS_ID'],
              ENV['AWS_SECRET_KEY']
              )})
          @aws_client = Aws::S3::Client.new
          @aws_client
        end      

        # Aws Configuração Resources S3 
        def aws_configurations_resources
          @s3 = Aws::S3::Resource.new(region: 'us-west-2')
          @s3 
        end

        # Select Bucket and Doc Base 
        ## procuracao_simples => Procuração Simples
        def aws_doc(bucket="prcstudio3herokubucket", client, document)
          aws_configurations_client
          aws_doc = @aws_client.get_object(bucket:bucket, key:"base/#{document}.docx")
          @aws_body = aws_doc.body
          @doc = Docx::Document.open(@aws_body)
          @doc
          #raise
        end

        # Aws Custom Model with logo (criar modelos customizados com logo)
        def aws_custom_model_wit_logo;end


        # Aws Search Document by name and ID 
        def aws_search_by_name_and_id;end

        # Aws Search by Client List
        def aws_search_by_client_list;end

        # Aws Metadata => Muitos campos para arrumar 
        def aws_metadata(document_key, document_name, client_id, user_id, document_type, aws_link, user)
        metadata = {
          :document_key => ch_file,
          :document_name => "procuracao_simples-#{nome_correto}_#{client.id}.docx",
          :client_id => "#{client.id}",
          :"user_id" => "#{current_user.id}",
          :document_type => document.to_s,
          :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
          :user => "#{current_user.id}"
           }
        end
        
        def save_name(client)
          save_name = client[:name].downcase.gsub(/\s+/, "")
        end


        # Aws Save
        def aws_save(client, document, bucket='prcstudio3herokubucket')
          aws_configurations_resources
          aws_doc(client, document)
          doc = Docx::Document.open(@aws_body)              
          doc_templated = Templater::TemplaterService.replacer(client, doc)
          ch_save = doc_templated.save(Rails.root.join("tmp/#{document}-#{client[:name].downcase.gsub(/\s+/, "")}_#{client.id}.docx").to_s)
          ch_file = "tmp/#{document}-#{client[:name].downcase.gsub(/\s+/, "")}_#{client.id}.docx"
          obj = @s3.bucket(bucket).object(ch_file)
          # aws_metadata(ch_file, document_name )
          obj.upload_file(ch_file)
          #obj.upload_file(ch_file, metadata: metadata)
        end
        


        # Bucket 
        # - Criar Arquivo de Configuração Fixo => Bucket não irá mudar 
        # - Criar pastas nos Buckets
        # - Autocriar pastas nos Buckets ao criarmos mais sistemas procstudinhos
        # - /master_id/base
        # - /master_id/client_id/


        
    
        #backup
        #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
        #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
        #obj = @s3.bucket(bucket).object(ch_file)
        #backup



























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