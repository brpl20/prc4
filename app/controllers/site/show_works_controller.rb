# frozen_string_literal: true

module Site
  # Class que controla as acoes de visualizacao do cliente
  class ShowWorksController < SiteController
    include ClientsHelper
    def show
      @client = Client.find(params[:client_id])
      @client_type = retrieve_type_to_link(@client.client_type)
      @works = Work.includes(:client_works).where(client_works: { client_id: params[:client_id] })
    end
  end
end
