# frozen_string_literal: true

module Site
  # Class que controla as acoes de visualizacao do cliente
  class ShowWorksController < SiteController
    before_action :authenticate_customer!

    include ClientsHelper
    def show
      @customer = CustomerService.data_for_home(current_customer)

      @client = Client.find(params[:client_id])
      @client_type = retrieve_type_to_link(@client.client_type)
      @works = Work.includes(:client_works).where(client_works: { client_id: params[:client_id] })
    end
  end
end
