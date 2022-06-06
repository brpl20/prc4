# frozen_string_literal: true

module ApplicationHelper
  def office_phone
    Office.where(user_id: current_user.id).last.telephone
  end

  def office_address
    office = Office.where(user_id: current_user.id).last
    "#{office.address}. #{office.city} - #{office.state}"
  end

  def office_name
    Office.where(user_id: current_user.id).last.name
  end

  def office_site
    Office.where(user_id: current_user.id).last.site
  end

  def retrieve_value_from_array(object, value)
    object[value][0]
  end
end
