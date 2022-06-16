module OfficeTypesHelper
  def description_office_type(id)
    OfficeType.find(id).description
  end
end
