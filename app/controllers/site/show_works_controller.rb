# frozen_string_literal: true

module Site
  # Class que controla as acoes de visualizacao do cliente
  class ShowWorksController < SiteController
    before_action :authenticate_customer!

    include ClientsHelper

    def index
      @customer = Client.joins(:emails).find_by(emails: { email: current_customer.email })

      redirect_to client_works_show_path(@customer) if @customer.client_type.zero?

      @clients = Client.joins(:customer_types).where(customer_types: { represented: @customer.id })
    end

    def show
      @customer = CustomerService.data_for_home(current_customer)

      @client = Client.find(params[:client_id])
      @client_type = retrieve_type_to_link(@client.client_type)
      @works = Work.includes(:client_works).where(client_works: { client_id: params[:client_id] })
    end
  end
end
