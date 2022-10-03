# frozen_string_literal: true

# Controladora do cliente
class ClientsController < BackofficeController
  include ClientsHelper
  before_action :set_client, only: %i[show edit update destroy]
  before_action :retrieve_type, only: %i[new create edit update]

  def index
    @clients = ClientFilters.retrieve_clients
  end

  def search
    @clients = ClientFilters.retrieve_clients
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
    @type = retrieve_type_to_link(@client.client_type)

    if @client.save
      customer = CustomerService.create_customer(@client)
      NewCustomerEmailMailer.notify_new_customer(customer).deliver

      flash[:notice] = 'Cliente criado com sucesso'
      redirect_to clients_path
      templater(@client, 'procuracao_simples')
    else
      render :new
    end
  end

  def edit; end

  def update
    @type = retrieve_type_to_link(@client.client_type)
    if @client.update(client_params)
      redirect_to clients_path, notice: 'Client Atualizado. Cuidado * Procuracão não Atualizada'
    else
      render :edit
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
    @type = retrieve_type_to_link(@client.client_type)
    @client = Client.find(params[:id])
    @url_work = @client.client_works
    @url_job = @client.jobs
  end



  # AWS_SERVICE
  # def aws_configurations
  #   aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
  #       ENV['AWS_ID'],
  #       ENV['AWS_SECRET_KEY']
  #       )})
  #   @aws_client = Aws::S3::Client.new
  #   @s3 = Aws::S3::Resource.new(region: 'us-west-2')
  # end
  # AWS_SERVICE

  def office_check_and_select
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
      # nao vai funcionar pq nao tem o laywers
    end
    return @office
  end

  # FULL QUALIFICATION
  # ....

  #
  # FULL QUALIFICATION


  def templater(client, document)
    require 'aws-sdk-s3'
    require 'docx'
    require 'json'
    require 'time'
    require 'rails-i18n'

    # AWS CONFIG AND DOC
    AwsService::AwsService.aws_configurations
    raise

    aws_doc = @aws_client.get_object(bucket:"prcstudio3herokubucket", key:"base/#{document}.docx")
    aws_body = aws_doc.body

    # FIELD
    # office_check_and_select
    nome_cap = "#{@client[:name]}".upcase
    sobrenome_cap = "#{@client[:lastname]}".upcase
    emails = [].join('')
    client.emails.each do | em |
      emails << "#{em.email}, "
    end


    # Template::TemplaterService.full_qualify_person(client, :full)

    client.full_qualify_person(client, :full)
    client.full_qualify_representative(client)

    if @client[:capacity] = 'Capaz' || @client[:capacity] = nil
      capacity_treated = @client[:capacity]
    else
      capacity_treated =
        "#{@client[:capacity]}, representado por seu genitor(a): ------ Qualificar manualmente o representante legal --"
    end

    lawyers = UserProfileFilters.by_role(0)
    paralegals = UserProfileFilters.by_role(1)
    interns = UserProfileFilters.by_role(2)

    laws = if lawyers.size > 0.5
      ['Advogados: '].join('')
     else
        ' '
     end

    parals = if paralegals.size > 0.5
      ['Paralegais: '].join('')
    else
      ' '
    end

    inters = if interns.size > 0.5
      ['Estagiários: '].join('')
    else
      ' '
    end

    lawyers.each_with_index do |x, index|
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
        tr.substitute('_:c_nome_', client.full_name(client))
        #tr.substitute('_:c_estado_civil_', client.genderize(client.civilstatus))

        tr.substitute('_:c_profissao_', client.profession.downcase)
        tr.substitute('_:c_capacidade_', capacity_treated.downcase)
        #tr.substitute('_:c_nacionalidade_', client.genderize(client.citizenship).downcase)

        tr.substitute('_:c_rg_', @client[:general_register])
        tr.substitute('_:c_cpf_', (@client[:social_number]).to_s)
        #tr.substitute('_:c_nb_', nb_exist)
        tr.substitute('_:c_email_', @client.emails[0].email)
        tr.substitute('_:c_endereco_', @client[:address])
        tr.substitute('_:c_cidade_', @client[:city])
        tr.substitute('_:c_state_', @client[:state])
        tr.substitute('_:c_cep_', (@client[:zip]).to_s)
        tr.substitute('_:c_empresa_atual_', @client[:company])

        tr.substitute('_:o_lawyers_', laws)
        tr.substitute('_:o_sociedade_', office)
        tr.substitute('_:o_parl_', parals)
        # paralegais
        tr.substitute('_:o_est', inters)
        # interns estagiario
        tr.substitute('_:o_addressoficial_', office_address)
        tr.substitute('_:o_emailoficial_', office_email)

        #tr.substitute('_:c_portador_', porta)
        #tr.substitute('_:c_inscrito_', inscrito)
        #tr.substitute('_:c_domiciliado_', domiciliado)

        tr.substitute('_:timestamp_', dia)
      end
    end
    console
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

  def retrieve_type
    @type = params[:type]
  end
end
