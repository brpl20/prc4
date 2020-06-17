class UserMailer < ApplicationMailer
  def welcome_email(user)
    mail(:to => user, :subject => "Welcome!")
  end
end
