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
      NewCustomerEmailMailer.notify_new_customer(customer).deliver_later if params[:flag_access_data]
      generate_docs(@client)
      flash[:notice] = 'Cliente criado com sucesso'
      redirect_to clients_path
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
    @generate_docs = generate_docs(@client)
  end

  def generate_docs(client)
    AwsService::AwsService.aws_save_client(client, document="procuracao_simples", bucket='prcstudio3herokubucket')
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
