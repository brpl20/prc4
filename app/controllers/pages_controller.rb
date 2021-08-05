class PagesController < ApplicationController
  #skip_authorization_check
  before_action :amazon_client, :authenticate_user!, :except => [:help, :clt_covid, :clt_covid_s3]

  def index
  end

  def dashboard
    @clients = Client.all
    @works = Work.last(3)
  end

  def help
  end

  def plans
  end

  def clt_covid
  end

  def clt_covid_s3
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require 'time'
    require 'rails-i18n'

    # AWS STUFF -- INICIO --
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/covid_clt.docx")
    aws_body = aws_doc.body
    
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|
        # CLIENT
        # byebug
        tr.substitute('_:cnpj_', params[:cnpj])
      end
    end
    bucket = 'prcstudio3herokubucket'
    #nome_correto = client[:name].downcase.gsub(/\s+/, "") # nao utilizado -- utilizado o hash no lugar 

    ch_save = doc.save(Rails.root.join("tmp/covid_clt-hash.docx").to_s)

    ch_file = "tmp/covid_clt-hash.docx"

    obj = @s3.bucket(bucket).object(ch_file)

    #backup
      #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
      #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
      #obj = @s3.bucket(bucket).object(ch_file)
    #backup
    metadata = {
            :document_name => "covid_clt-hash.docx",
            :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/covid_clt-hash.docx",
             }
    obj.upload_file(ch_file, metadata: metadata)
  end


  private



  def amazon_client
   require 'aws-sdk-s3'
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')
  end

end
