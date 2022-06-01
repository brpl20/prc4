module ApplicationHelper

  def footer_phone
    current_user.office.telephone
  end

  def footer_address
    "#{current_user.office.address}. #{current_user.office.city} - #{current_user.office.state}"
  end

  def retrieve_value_from_array(object, value)
    object[value][0]
  end
end
