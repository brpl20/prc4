module OfficesHelper
  def options_for_office
    #Office.order(:name).map{|c| ["#{c.name}", c.id] }
    offices = Office.all.order(:id)

    response = []

    offices.each do |o|
      response << {
        office_id: o.id,
        office_name: o.name,
        users: UserProfile.where(office_id: o.id).pluck(:name, :lastname, :id, :office_id)
      }
    end
    response
    #response.map{|c| ["#{c[:office_name]}", c[:office_id]]}
  end

  def options_for_adv_office
    options = []

    options_for_office.each do |office|
      office[:users].each do |user|
        options << [user[0] + " " + user[1], user[2], {'data-office'=> office[:office_name]}]
      end
    end
    options
  end

  def options_for_responsible
    user = UserProfile.all.pluck(:user_id)
    User.where(id: user)
  end

  def options_for_office_type
    OfficeType.all
  end

  def options_for_society
    [
      ['Unipessoal', 'Unipessoal'],
      ['Sociedade', 'Sociedade'],
      ['Pessoa física', 'Pessoa física']
    ]
  end

end
