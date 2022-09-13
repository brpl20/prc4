module Site::ShowWorksHelper
  def retrieve_type_to_link(type)
    case type
    when 0
      'pf'
    when 1
      'pj'
    when 2
      'rep'
    when 3
      'cont'
    end
  end
end
