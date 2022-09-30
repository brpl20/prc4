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

      customer
    end

    def create_customer_client(client, customer)
      CustomerClient.create!(
        client: client,
        customer: customer
      )
    end

    def data_for_home(customer)
      # Precisamos criar uma tela principal para o customer acessar e escolher qual cliente ele vai ver os processos;

      # a definir
      # Customer acessa dashboard via endpoint /cliente;
      # Se customer PF visualiza cards de clientes e seleciona algum;
        # Visualiza /area_cliente/:client_id/trabalhos do cliente selecionado
      # Se customer PF visulualiza /area_cliente/:client_id/trabalhos;

      # criar regras de negocio para visualizacao dos representantes / representados
    end
  end
end
