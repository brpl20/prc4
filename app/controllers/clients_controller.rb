class ClientsController < ApplicationController
  before_action :authenticate_user!, :amazon_client, :set_client, only: [:show, :edit, :update, :destroy]

  def index
    @clients = Client.includes(:phones,:emails).all
  end

  def new
    @client = Client.new
    @client.phones.build
    @client.emails.build
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      if @client[:choice] == true || nil
        templater(@client, 'procuracao_simples')
        flash[:notice] = "Cliente Criado" 
        redirect_to @client
      elsif @client[:choice] == false
        redirect_to new_work_path(client: @client),
          notice: "Cliente criado com sucesso, redirecionando para Trabalhos"
          # TODO: Terminar os redirecionamentos aqui
      else
        render :new,
        notice: "Erro - Renderizando Novo !"
      end
    end
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
    @client.destroy
    redirect_to clients_path
  end

  def show
    require 's3'
    service = S3::Service.new(
      :access_key_id => ENV['AWS_ID'],
      :secret_access_key => ENV['AWS_SECRET_KEY']
     )
    @client = Client.find(params[:id])
    # TODO -> Arrumar aqui pq os clientes que nao sao 
    # Consulta Simples nao estao aparecendo no view
    # Pq nao existe documento gerado 
    
    doc_link = @client.documents["document_name"]
    @client.documents[:aws_link]
    @meta = []
    @meta2 = []
    #criar objeto
    @bucket = service.buckets.find("prcstudio3herokubucket")
    @object = @bucket.objects.find("tmp/#{doc_link}")
    @url = @object.temporary_url(Time.now + 1800)
    @meta << @object
  end


  # FEMININ x MASCULIN (TODO: Create Module or Helper)
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
     else
      "em União Estável"
     end
   end


  def templater(client, document)
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

    aws_doc = @aws_client.get_object(bucket:'prcstudio3herokubucket', key:"base/#{document}.docx")
    aws_body = aws_doc.body
    # AWS STUFF -- FIM --

    # FIELD TREAT -- INICIO --

    # SIMPLE FIELDS
    nome_completo = "#{@client[:name]} #{@client[:lastname]}".upcase
    nome_cap = "#{@client[:name]}".upcase
    sobrenome_cap = "#{@client[:lastname]}".upcase
    emails = [].join("")
    client.emails.each do | em |
      emails << "#{em.email}, "
    end

    # NUMERO DE BENEFICIO FIELD
    if @client[:number_benefit].nil?
      nb_exist = ""
    else
      nb_exist = "número de benefício #{@client[:number_benefit]},"
    end

    # NO DB FIELDS CONFIG GENDER
    # GENDER LOGIC
    if @client[:gender] == 2
      civilstatus = genderize(@client[:civilstatus])
      nacionalita = genderize(@client[:citizenship])
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      civilstatus = @client[:civilstatus]
      nacionalita = @client[:citizenship]
      porta = "portador"
      inscrito = "inscrito"
      domiciliado = "domiciliado"
    end

    if @client[:capacity] = 'Capaz' || @client[:capacity] = nil
      capacity_treated = @client[:capacity]
    else
      capacity_treated = "#{@client[:capacity]}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal ----"
    end

    # ADVOGADOS
    laws = [].join("")
    Lawyer.all.each do | xopo |
      laws << "#{xopo.name} #{xopo.lastname} #{xopo.civilstatus} OAB/PR #{xopo.oab_number}, ".to_s
    end

    # ESCRITORIO

    # erro no PRC4
    #esc = Escritorio.pluck(:name, :oab, :city, :state, :email).join(", ")

    # FIELD TREAT -- FIM --

    # PODERES

    # TIME - HORARIO
    dia = I18n.l(Time.now, format: "%d de %B de %Y")

    # DOCUMENT REPLACES
    doc = Docx::Document.open(aws_body)
    doc.paragraphs.each do |p|
      p.each_text_run do |tr|
        # CLIENT
        tr.substitute('_:nome_', nome_cap)
        tr.substitute('_:sobrenome_', sobrenome_cap)
        tr.substitute('_:estado_civil_', civilstatus.downcase)
        tr.substitute('_:profissao_', @client[:profession].downcase)
        tr.substitute('_:capacidade_', capacity_treated.downcase)
        tr.substitute('_:nacionalidade_', nacionalita.downcase)
        tr.substitute('_:rg_', @client[:general_register])
        tr.substitute('_:cpf_', (@client[:social_number]).to_s)
        tr.substitute('_:nb_', nb_exist)
        tr.substitute('_:email_', emails)
        tr.substitute('_:endereco_', @client[:address])
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
        tr.substitute('_:timestamp_', dia)
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
      :address,
      :city,
      :state,
      :zip,
      :note,
      :documents,
      :choice,
      phones_attributes: [:id, :phone, :_destroy],
      emails_attributes: [:id, :email, :_destroy]
      )
  end

  # TODO : Lembrar que note e choose não possuem
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
