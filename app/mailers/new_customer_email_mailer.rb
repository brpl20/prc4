# frozen_string_literal: true

# classe responsavel por envio de emails
class NewCustomerEmailMailer < ApplicationMailer
  def notify_new_customer(customer)
    @customer = customer
    mail(to: @customer.email, subject: 'Seu acesso ao sistema ProcStudio')
  end
end
