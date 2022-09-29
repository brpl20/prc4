# frozen_string_literal: true

# service para controle dos metodos de customers
class CustomerService
  class << self

    def create_customer(client)
      customer = Customer.create!(
        email: client.emails.first.email,
        password: 'Cliente123#',
        password_confirmation: 'Cliente123#'
      )
      create_customer_client(client, customer)
    end

    def create_customer_client(client, customer)
      CustomerClient.create!(
        client: client,
        customer: customer
      )
    end
  end
end
