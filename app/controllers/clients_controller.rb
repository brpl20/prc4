# frozen_string_literal: true

# Controladora do cliente
class ClientsController < BackofficeController
  before_action :amazon_client, :set_client, only: %i[show edit update destroy]
  before_action :retrieve_type, only: %i[new create edit update]

  def index
    @clients = ClientFilters.retrive_clients
  end

  def search
    @clients = ClientFilters.retrive_clients
    respond_to do |format|
      format.js { render partial: 'clients/modal/recommendation_search' }
    end
  end

  def representative_search
    @clients = ClientFilters.retrive_representative_search
    respond_to do |format|
      format.js { render partial: 'clients/modal/representative_search' }
    end
  end

  def representative_accountant_search
    @clients = ClientFilters.retrive_representative_accountant_search
    respond_to do |format|
      format.js { render partial: 'clients/modal/representative_accountant_search' }
    end
  end

  def new
    @client = Client.new
    @client.build_bank
    @client.phones.build
    @client.emails.build
    @client.customer_types.build if @client.customer_types
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:notice] = 'Cliente criado com sucesso'
      redirect_to clients_path
    else
      render :new
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_path, notice: 'Client Atualizado. Cuidado * Procuracão não Atualizada' }
        format.json { render :show, status: :ok, location: clients_path }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if Client.can_be_destroyed(@client.id)
      redirect_to clients_path, notice: 'Cliente não pode ser excluído, pois possui trabalhos anteriores.'
    else
      @client.destroy
      redirect_to clients_path, notice: 'Cliente excluído com sucesso.'
    end
  end

  def show
    @client = Client.find(params[:id])
    @url_work = @client.client_works
    @url_job = @client.jobs
  end

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

    aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
        ENV['AWS_ID'],
        ENV['AWS_SECRET_KEY']
        )})
    @aws_client = Aws::S3::Client.new
    @s3 = Aws::S3::Resource.new(region: 'us-west-2')

    aws_doc = @aws_client.get_object(bucket:"prcstudio3herokubucket", key:"base/#{document}.docx")
    aws_body = aws_doc.body

    nome_completo = "#{@client[:name]} #{@client[:lastname]}".upcase
    nome_cap = "#{@client[:name]}".upcase
    sobrenome_cap = "#{@client[:lastname]}".upcase
    emails = [].join("")
    client.emails.each do | em |
      emails << "#{em.email}, "
    end

    if @client[:number_benefit].nil? || @client[:number_benefit] == ""
      nb_exist = ""
    else
      nb_exist = "número de benefício #{@client[:number_benefit]},"
    end

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

    dia = I18n.l(Time.now, format: "%d de %B de %Y")

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

        tr.substitute('_:lawyers_', laws)
        tr.substitute('_:sociedade_', office)
        tr.substitute('_$parl_', parals)
        tr.substitute('$es', inters)
        tr.substitute('_:addressoficial_', office_address)
        # tr.substitute('_:emailoficial_', office_email)

        tr.substitute('_:portador_', porta)
        tr.substitute('_:inscrito_', inscrito)
        tr.substitute('_:domiciliado_', domiciliado)

        tr.substitute('_:timestamp_', dia)
      end
    end
    bucket = 'prcstudio3herokubucket'
    nome_correto = client[:name].downcase.gsub(/\s+/, "")

    #ch_save = doc.save(Rails.root.join("tmp/procuracao_simples-#{nome_correto}_#{client.id}.docx").to_s)

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
    #obj.upload_file(ch_file, metadata: metadata)
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
      :nit,
      :passwdInss,
      :number_benefit,
      :general_register,
      :cnpj,
      :social_number,
      :address,
      :city,
      :state,
      :zip,
      :note,
      :status,
      :documents,
      :choice,
      :client_type,
      files: [],
      bank_attributes:   [:id, :name, :agency, :account],
      phones_attributes: [:id, :phone, :_destroy],
      emails_attributes: [:id, :email, :_destroy],
      customer_types_attributes: [:id, :represented, :client_id, :description, :_destroy]
      )
  end

  def set_client
    @client = Client.find(params[:id])
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

  def retrieve_type
    @type = params[:type]
  end
end
