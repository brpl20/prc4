# frozen_string_literal: true

module ApplicationHelper
  def office_exist?
    user = current_user ? current_user.id : 1
    Office.exists?(user_id: user)
  end

  def office_phone
    if office_exist?
      user = current_user ? current_user.id : 1
      Office.where(user_id: user).last.telephone
    else
      office_phone = 'Telefone do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def office_address
    if office_exist?
      user = current_user ? current_user.id : 1
      office = Office.where(user_id: user).last
      "#{office.address}. #{office.city} - #{office.state}"
    else
      office_address = 'Endereço do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def office_name
    if office_exist?
      user = current_user ? current_user.id : 1
      Office.where(user_id: user).last.name
    else
      office_name = 'Nome do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def office_site
    if office_exist?
      user = current_user ? current_user.id : 1
      Office.where(user_id: user).last.site
    else
      office_site = 'Side do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def retrieve_value_from_array(object, value)
    object[value][0]
  end

end
