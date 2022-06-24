module OfficesHelper
  def options_for_office
    Office.all
  end

  def options_for_responsible
    user = UserProfile.all.pluck(:user_id)
    User.where(id: user)
  end

  def options_for_office_type
    OfficeType.all
  end
end
