class ClientsController < ApplicationController
  before_action :authenticate_user!, :amazon_client, :set_client, only: [:show, :edit, :update, :destroy]
  #before_action :set_client, only: [:new_rep]

  def index
    @clients = Client.includes(:phones,:emails).all
  end

  def new
    @client = Client.new
    @client.build_bank
    @client.phones.build
    @client.emails.build
  end

  def new_rep
    @client = Client.new
    incapable = Client.find(params[:id])
    @client.address = incapable.address
    # Continuar preenchimento
  end




  def create
    @client = Client.new(client_params)
    if @client.save
      if @client.capacity === "Capaz"
        #templater(@client, 'procuracao_simples')
        #templater desativado porque está dando NIL na segunda geracao de doc
        flash[:notice] = "Cliente Criado - Procuração Simples Gerada"
        redirect_to @client
      else
        flash[:notice] = "Cliente Incapaz Criado - Redirecionando Para Representante Legal"
        redirect_to new_rep_path(@client)
        #render :action => "new"
        # ainda em duvida sobre usar render ou redirect_to (zerar os campos)
      end
    end
  end

  def edit

  end

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

    if @client.documents != nil
      doc_link = @client.documents["document_name"]
    else
      doc_link = "Sem documentos disponíveis"
    end
    @meta = []
    @meta2 = []
    #criar objeto
    @client.documents[:aws_link]
    @object = @bucket.objects.find("tmp/#{doc_link}")
    @bucket = service.buckets.find("prcstudio3herokubucket")
    @url = @object.temporary_url(Time.now + 1800)
    @meta << @object

    @civilstatus = get_civilstatus(@client.civilstatus)
    if @client.documents == nil
      @url = "Sem Docs Cadastrados"
      @documents = "Sem Docs Cadastrados"
    else
      @url = @client.documents['aws_link']
    end
    @url_work = @client.client_works
    @url_job = @client.jobs
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

   def get_civilstatus(status)
     case status
       when '1'
         'Solteiro(a)'
       when '2'
         'Casado(a)'
       when '3'
         'Divorciado(a)'
       when '4'
         'Viúvo(a)'
       when '5'
         'em União Estável'
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

    aws_doc = @aws_client.get_object(bucket:"prcstudio3herokubucket", key:"base/#{document}.docx")
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
    if @client[:number_benefit].nil? || @client[:number_benefit] == ""
      nb_exist = ""
    else
      nb_exist = "número de benefício #{@client[:number_benefit]},"
    end

    # NO DB FIELDS CONFIG GENDER
    # GENDER LOGIC
    if @client[:gender] == 2
      civilstatus = client.civilstatus
      nacionalita = genderize(@client[:citizenship])
      porta = "portadora"
      inscrito = "inscrita"
      domiciliado = "domiciliada"
    else
      civilstatus = client.civilstatus
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

    # ADVOGADOS - PARALEGAIS - ESTAGIARIOS
    lawyers = UserProfile.lawyer
    paralegals = UserProfile.paralegal
    interns = UserProfile.intern


    if lawyers.size > 0.5
      laws = ["Advogados: "].join("")
    else
      laws = [""].join("")
    end

    if paralegals.size > 0.5
      parals = ["Paralegais: "].join("")
    else
      parals = [""].join("")
    end

    if interns.size > 0.5
      inters = ["Estagiários: "].join("")
    else
      inters = [""].join("")
    end

    lawyers.each_with_index do | x, index |
      if index == lawyers.size-1
        laws << "#{x.name} #{x.lastname}, #{x.civilstatus}, OAB/PR #{x.oab}.".to_s
      else
        laws << "#{x.name} #{x.lastname}, #{x.civilstatus}, OAB/PR #{x.oab}, ".to_s
      end
    end

    paralegals.each_with_index do | x, index |
      if index == paralegals.size-1
        parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      else
        parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      end
    end

    interns.each_with_index do | x, index |
      if index == interns.size-1
        inters << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      else
        inters << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      end
    end

    # ESCRITORIO
    offices = Office.all
    if offices.size > 0.5
      office_sel = Office.find_by_id(1)
      office = ["Escritório: "].join("")
      office_email = office_sel.email
      office_address = "#{office_sel.address}, #{office_sel.city}, #{office_sel.state}."
      office << "#{office_sel.name}"
    else
      office = [""].join("")
      office_address = "#{lawyers[1]}"
    end



    # Address . similar ?
    # if lawyer.address.similar(lawyer.address)
    #   lawyer.office


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
        # LAWYER - PARALEGALS - INTERNS - SOCIETY
        tr.substitute('_:lawyers_', laws)
        tr.substitute('_:sociedade_', office)
        tr.substitute('_$parl_', parals)
        tr.substitute('$es', inters)
        tr.substitute('_:addressoficial_', office_address)
        tr.substitute('_:emailoficial_', office_email)

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
      :status,
      :documents,
      :choice,
      bank_attributes:   [:id, :name, :agency, :account],
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
