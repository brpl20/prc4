class ClientFilters

  class << self

    def retrive_clients
      Client.includes(:phones, :emails, :customer_types).all
    end

    def retrive_representative_search
      retrive_clients.where(client_type: 2)
    end

    def retrive_representative_accountant_search
      types = [2, 3]
      retrive_clients.where(client_type: types)
    end

  end

end
