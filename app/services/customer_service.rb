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

    def data_for_home(customer)
      p '-----------------------------------------------------------'
      p customer

      # criar tela principal para o customer acessar e escolher qual cliente ele vai ver os processos;
      # ajustar tela de visualizacao dos processos para ela nao mostrar o nome do customer / cliente
    end
  end
end
