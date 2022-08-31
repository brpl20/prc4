module TemplaterOffice

  class TemplaterOfficeService

    class << self

      def self.officesSelection
      offices = Office.all
        if offices.size > 0.5
          office_sel = Office.find_by_id(1)
          office = ["Escritório: "].join("")
          office_email = office_sel.email
          office_address = "#{office_sel.address}, #{office_sel.city}, #{office_sel.state}."
          office << "#{office_sel.name}"
          return office
        else
          office = [""].join("")
          office_address = "#{lawyers[1]}"
          return office
        end
      end



    lawyers = UserProfile.lawyer
    paralegals = UserProfile.paralegal
    interns = UserProfile.intern

    if lawyers.size > 0.5
      laws = ["Advogados: "].join("")
    else
      laws = [""].join("")
    end

    if paralegals.size > 0.5
      parals = ["Paralegais: "].join("")
    else
      parals = [""].join("")
    end

    if interns.size > 0.5
      inters = ["Estagiários: "].join("")
    else
      inters = [""].join("")
    end

    lawyers.each_with_index do | x, index |
      if index == lawyers.size-1
        laws << "#{x.name} #{x.lastname}, #{x.civilstatus}, OAB/PR #{x.oab}.".to_s
      else
        laws << "#{x.name} #{x.lastname}, #{x.civilstatus}, OAB/PR #{x.oab}, ".to_s
      end
    end

    paralegals.each_with_index do | x, index |
      if index == paralegals.size-1
        parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      else
        parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      end
    end

    interns.each_with_index do | x, index |
      if index == interns.size-1
        inters << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      else
        inters << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      end
    end





    end

  end

end
