# frozen_string_literal: true

# Controladora do cliente
class ClientsController < BackofficeController
  include ClientsHelper
  before_action :set_client, only: %i[show edit update destroy generate_docs_show]
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
  
  # BEGIN & RESCUE
  def metadata_create(client)
    if client.documents == nil
      document_number = 1
      metadata = {
        :document_count => document_number.to_s,
        :user_id => current_user.id.to_s,
        :document_nickname => "Procuracao Simples",
      }
      client.documents = metadata
    else
      document_number = client.documents["document_count"].to_i+1
      metadata = {
        :document_count => document_number.to_s,
        :user_id => current_user.id.to_s,
        :document_nickname => "Procuracao Simples",
      }
      client.update(documents:metadata)
      metadata
    end 
  end

  def create
    @client = Client.new(client_params)
    @type = retrieve_type_to_link(@client.client_type)
    customer = CustomerService.create_customer(@client)
    NewCustomerEmailMailer.notify_new_customer(customer).deliver_later if params[:flag_access_data]
    # TEST FLAGS - TODO - ARRUMAR PARAMS 
    # PARAMS 
    # if @client[:flag_access_data] == 1 
    #   puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    #   puts "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- "
    # end 
    # TEST FLAGS
    metadata_create(@client)
    generate_docs(@client)
    flash[:notice] = 'Cliente criado com sucesso'
    redirect_to clients_path
    if @client.save
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
    #@generate_docs = generate_docs_show(@client)
  end

  def generate_docs(client)
    AwsService::AwsService.aws_save_client(client, document="procuracao_simples", bucket='prcstudio3herokubucket', meta=client.documents)
  end

  # def generate_docs_show
  #   AwsService::AwsService.aws_save_client(client, document="procuracao_simples", bucket='prcstudio3herokubucket', meta=metadata_create(client))
  # end

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
