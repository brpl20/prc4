# frozen_string_literal: true

module ApplicationHelper
  def office_exist?
    Office.exists?(user_id: current_user.id)
  end

  def office_phone
    if office_exist?
      Office.where(user_id: current_user.id).last.telephone
    else
      office_phone = 'Telefone do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def office_address
    if office_exist?
      office = Office.where(user_id: current_user.id).last
      "#{office.address}. #{office.city} - #{office.state}"
    else
      office_address = 'Endereço do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def office_name
    if office_exist?
      Office.where(user_id: current_user.id).last.name
    else
      office_name = 'Nome do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def office_site
    if office_exist?
      Office.where(user_id: current_user.id).last.site
    else
      office_site =  'Side do Escritório Não cadastrado - Configure o Escritório'
    end
  end

  def retrieve_value_from_array(object, value)
    object[value][0]
  end

end
