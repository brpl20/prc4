# frozen_string_literal: true

# service para controle dos metodos de customers
class CustomerService
  class << self
    def create_customer(client)
      p 'criando ****************8'
      Customer.create!(
        email: client.emails.first.email,
        password: 'Cliente123#',
        password_confirmation: 'Cliente123#'
      )
    end
  end
end
