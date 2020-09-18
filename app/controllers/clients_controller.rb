class ClientsController < ApplicationController
  before_action :authenticate_user!, :amazon_client, :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.all
  end

  def show
    require 's3'
    # service = S3::Service.new(
    #   :access_key_id => ENV['AWS_ID'],
    #   :secret_access_key => ENV['AWS_SECRET_KEY']
    #  )
    @client = Client.find(params[:id])
    # doc_link = @client.documents["document_name"]
    # @client.documents[:aws_link]
    # @meta = []
    # @meta2 = []
    # #criar objeto
    # @bucket = service.buckets.find("prcstudio3herokubucket")
    # @object = @bucket.objects.find("tmp/#{doc_link}")
    # @url = @object.temporary_url(Time.now + 1800)
    # @meta << @object
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      templater(@client, 'procuracao_simples')
      if @client[:choose] == true
        redirect_to @client
      elsif @client[:choose] == false
        redirect_to new_work_path(
          :lawyer_id => 1,
          :civilstatus => @client[:civilstatus]),
          notice: "Cliente criado com sucesso, redirecionando para Trabalhos"
      else
        render :new,
        notice: "Erro!"
      end
    end
  end

  # FIELD CHECKER
  # TO KNOW IF IS NIL
  # AND MAKE A BLANK " " TO REPLACE
  # INEXISTENT FIELD IN DOCUMENT
  def fcheck(field)
  if field.nil?
    field_replaced = ""
  end
  end

  # RECIBO
  def receipt
    @client = Client.find(params[:client_id])
    templater_receipt(@client, 'recibo_simples')
    # @benefits = params[:benefits]
    # render :receipt
  end

  def templater_receipt(client, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require "time"

    # AWS STUFF -- INICIO --
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')

    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body
    # AWS STUFF -- FIM --

    # FIELD TREAT -- INICIO --
    nome_completo = "#{@client[:name]} #{@client[:lastname]}".upcase
    nome_cap = "#{@client[:name]}".upcase
    sobrenome_cap = "#{@client[:lastname]}".upcase

    # NO DB FIELDS CONFIG GENDER

    # GENDER LOGIC
    if @client[:gender] == 2
      estado_civil = genderize(@client[:civilstatus])
      nacionalita = genderize(@client[:citizenship])
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      estado_civil = @client[:civilstatus]
      nacionalita = @client[:citizenship]
      porta = "portador"
      inscrito = "inscrito"
      domiciliado = "domiciliado"
    end

    if @client[:capacity] = 'Capaz' || @client[:capacity] = nil
      capacidade = @client[:capacity]
    else
      capacidade = "#{@client[:capacity]}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal ----"
    end

    # ADVOGADOS
    laws = [].join("")
    Lawyer.all.each do | xopo |
      laws << "#{xopo.name} #{xopo.sobrenome}, #{xopo.civilstatus}, OAB/PR n #{xopo.oab_number}. ".to_s
    end

    # ESCRITORIO

    # erro no PRC4
    #esc = Escritorio.pluck(:name, :oab, :city, :state, :email).join(", ")

    # FIELD TREAT -- FIM --

    # PODERES

    # TIME - HORARIO
    data = Time.now
    data2 = data.strftime("%d, %m, %Y")
    #data.format("DD, MM, YYYY")


    # DOCUMENT REPLACES
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|
        # CLIENT
        tr.substitute('_:nome_', nome_cap)
        tr.substitute('_:sobrenome_', sobrenome_cap)
        tr.substitute('_:estado_civil_', estado_civil)
        tr.substitute('_:profissao_', @client[:profession].downcase)
        tr.substitute('_:capacidade_', capacidade.downcase)
        tr.substitute('_:nacionalidade_', nacionalita.downcase)
        tr.substitute('_:rg_', @client[:general_register])
        tr.substitute('_:cpf_', (@client[:social_number]).to_s)
        tr.substitute('_:nb_', (@client[:number_benefit]).to_s)
        tr.substitute('_:email_', @client[:email])
        tr.substitute('_:endereco_', @client[:adress])
        tr.substitute('_:cidade_', @client[:city])
        tr.substitute('_:state_', @client[:state])
        tr.substitute('_:cep_', (@client[:zip]).to_s)
        tr.substitute('_:empresa_atual_', @client[:company])
        # LAWYER end Society
        tr.substitute('_:lawyers_', laws)
        tr.substitute('_:sociedade_', "")
        # NO DB FIELDS CONFIG GENDER
        tr.substitute('_:portador_', porta)
        tr.substitute('_:inscrito_', inscrito)
        tr.substitute('_:domiciliado_', domiciliado)
        # PODERES TODO

        # DOCUMENT TIME STAMP
        tr.substitute('_:timestamp_', data2)
      end
    end
    bucket = 'prcstudio3herokubucket'
    nome_correto = client[:name].downcase.gsub(/\s+/, "")

    ch_save = doc.save(Rails.root.join("tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
    ch_file = "tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx"
    obj = @s3.bucket(bucket).object(ch_file)

    #backup
      #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
      #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
      #obj = @s3.bucket(bucket).object(ch_file)
    #backup

    metadata = {
                :document_key => ch_file,
                :document_name => "procuracao_simples-#{nome_correto}_#{client.id}.docx",
                :client_id => "#{client.id}",
                :"user_id" => "#{current_user.id}",
                :document_type => document.to_s,
                :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
                :user => "#{current_user.id}"
                 }
    client.documents = metadata
    client.save
    obj.upload_file(ch_file, metadata: metadata)
  end


 # FEMININ x MASCULIN
  def genderize(field)
    case field
    when "Casado"
      field.sub! 'Casado', 'Casada'
    when "Solteiro"
      field.sub! 'Solteiro', 'Solteira'
    when "Divorciado"
      field.sub! 'Divorciado', 'Divorciada'
    when "Viúvo"
      field.sub! 'Viúvo', 'Viúva'
    when "Brasileiro"
      field.sub! 'Brasileiro', 'Brasileira'
    when "Estrangeiro"
      field.sub! 'Estrangeiro', 'Estrangeira'
    end
  end



  def templater(client, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require "time"

    # AWS STUFF -- INICIO --
    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')

    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body
    # AWS STUFF -- FIM --

    # FIELD TREAT -- INICIO --
    nome_completo = "#{@client[:name]} #{@client[:lastname]}".upcase
    nome_cap = "#{@client[:name]}".upcase
    sobrenome_cap = "#{@client[:lastname]}".upcase

    # NO DB FIELDS CONFIG GENDER

    # GENDER LOGIC
    if @client[:gender] == 2
      estado_civil = genderize(@client[:civilstatus])
      nacionalita = genderize(@client[:citizenship])
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      estado_civil = @client[:civilstatus]
      nacionalita = @client[:citizenship]
      porta = "portador"
      inscrito = "inscrito"
      domiciliado = "domiciliado"
    end

    if @client[:capacity] = 'Capaz' || @client[:capacity] = nil
      capacidade = @client[:capacity]
    else
      capacidade = "#{@client[:capacity]}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal ----"
    end

    # ADVOGADOS
    laws = [].join("")
    Lawyer.all.each do | xopo |
      laws << "#{xopo.name} #{xopo.lastname}, #{xopo.civilstatus}, OAB/PR n #{xopo.oab_number}. ".to_s
    end

    # ESCRITORIO

    # erro no PRC4
    #esc = Escritorio.pluck(:name, :oab, :city, :state, :email).join(", ")

    # FIELD TREAT -- FIM --

    # PODERES

    # TIME - HORARIO
    data = Time.now
    data2 = data.strftime("%d, %m, %Y")
    #data.format("DD, MM, YYYY")


    # DOCUMENT REPLACES
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|
        # CLIENT
        tr.substitute('_:nome_', nome_cap)
        tr.substitute('_:sobrenome_', sobrenome_cap)
        tr.substitute('_:estado_civil_', estado_civil)
        tr.substitute('_:profissao_', @client[:profession].downcase)
        tr.substitute('_:capacidade_', capacidade.downcase)
        tr.substitute('_:nacionalidade_', nacionalita.downcase)
        tr.substitute('_:rg_', @client[:general_register])
        tr.substitute('_:cpf_', (@client[:social_number]).to_s)
        tr.substitute('_:nb_', (@client[:number_benefit]).to_s)
        tr.substitute('_:email_', @client[:email])
        tr.substitute('_:endereco_', @client[:adress])
        tr.substitute('_:cidade_', @client[:city])
        tr.substitute('_:state_', @client[:state])
        tr.substitute('_:cep_', (@client[:zip]).to_s)
        tr.substitute('_:empresa_atual_', @client[:company])
        # LAWYER end Society
        tr.substitute('_:lawyers_', laws)
        tr.substitute('_:sociedade_', "")
        # NO DB FIELDS CONFIG GENDER
        tr.substitute('_:portador_', porta)
        tr.substitute('_:inscrito_', inscrito)
        tr.substitute('_:domiciliado_', domiciliado)
        # PODERES TODO

        # DOCUMENT TIME STAMP
        tr.substitute('_:timestamp_', data2)
      end
    end
    bucket = 'prcstudio3herokubucket'
    nome_correto = client[:name].downcase.gsub(/\s+/, "")

    ch_save = doc.save(Rails.root.join("tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
    ch_file = "tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx"
    obj = @s3.bucket(bucket).object(ch_file)

    #backup
      #ch_save = doc.save(Rails.root.join("public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)
      #ch_file = "public/files/procuracao_simples-#{nome_correto}_#{client.id}.docx"
      #obj = @s3.bucket(bucket).object(ch_file)
    #backup

    metadata = {
                :document_key => ch_file,
                :document_name => "procuracao_simples-#{nome_correto}_#{client.id}.docx",
                :client_id => "#{client.id}",
                :"user_id" => "#{current_user.id}",
                :document_type => document.to_s,
                :aws_link => "https://#{bucket}.s3-us-west-2.amazonaws.com/#{ch_file}",
                :user => "#{current_user.id}"
                 }
    client.documents = metadata
    client.save
    obj.upload_file(ch_file, metadata: metadata)
  end

  def edit; end


  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client Atualizado. Cuidado * Procuracão Não Atualizada' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @clients.destroy
    redirect_to clients_path
  end


  def docx_upload(bucket='prcstudio3herokubucket', client, document)
  end




  private

  def client_params
    params.require(:client).permit(
      :gender,
      :name,
      :lastname,
      :citizenship,
      :capacity,
      :profession,
      :civilstatus,
      :company,
      :birth,
      :mothername,
      :number_benefit,
      :general_register,
      :social_number,
      :email,
      :adress,
      :city,
      :state,
      :bank,
      :agency,
      :account,
      :zip,
      :telephone,
      :notes,
      :documents,
      :choose
      )
  end

  # TODO : Lembrar que notes e choose não possuem
  # correspondência no DB

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client  = Client.find(params[:id])
  end

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
