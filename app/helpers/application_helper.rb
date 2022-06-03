# frozen_string_literal: true

module ApplicationHelper
  def office_phone
    Office.find(current_user.office_id).telephone
  end

  def office_address
    office = Office.find(current_user.office_id)
    "#{office.address}. #{office.city} - #{office.state}"
  end

  def office_name
    Office.find(current_user.office_id).name
  end

  def office_site
    Office.find(current_user.office_id).site
  end

  def retrieve_value_from_array(object, value)
    object[value][0]
  end
end
