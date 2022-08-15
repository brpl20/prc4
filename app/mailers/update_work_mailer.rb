class UpdateWorkMailer < ApplicationMailer
  def notify_new_work
    mail(to: 'pelli.br.sp@gmail.com', subject: 'Novo Trabalho Criado')

  end
end
