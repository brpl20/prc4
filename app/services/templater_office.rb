module TemplaterOffice

  class TemplaterOfficeService

    class << self

      # --------------------------------------
      # Intro
      # This is the place for dealing with Offices and Laywer
      # Both are related
      # An Office has one or more responsable laywers => Partnership
      # An Office can have one responsable laywers and subordinate lawyers
      # An Office can have Lawyer Employess 
      # --------------------------------------

      def full_qualify_lawyer_of_office(office)
        offices = [].join(', ')
        office_selected = Office.find_by_id(office)
        offices << office_templater(office_selected, UserProfile.find_by_id(office_selected.user_id))
      end

      # --------------------------------------
      # full_qualify(office) 
      # Is designed to create a single string with the office qualification
      # Qualification is the full name, selected attributes, details 
      # Later we will use this information for documents generation
      # Specially on Contracts where we need Office First and Secondly the Lawyer
      # --------------------------------------
      
      def office_check
        if Office.all.count > 0.5
          office_check = true
        else
          office_check = false
        end
      end 
      
      # --------------------------------------
      # office_check
      # check with office_grab
      # --------------------------------------

      def office_grab
        check = office_check
        lawyer = UserProfileFilters.by_role(0).first
        if check = true
          office_selected = Office.first
          user_selected = UserProfile.find_by_id(office_selected.user_id)
          office = office_templater(office_selected, lawyer = user_selected)
        else
          user_lawyer = UserProfileFilters.by_role(0).first
          office = office_templater_as_lawyer(user_lawyer)
          raise # todo - check this else 
        end
        office
      end 

      # --------------------------------------
      # office_check and office_grab
      # they are designed to check if we have an
      # Office into saved into the models
      # so we can use it to the documents as an office 
      # if we don't have an office we will use a lawyer/person 
      # into the documents, working along
      # by default it will be always the first user
      # --------------------------------------

      def office_templater(office, lawyer = nil, full_contract = nil)
        full_office = [].reject(&:blank?).join(', ')
        lawyer = Templater::TemplaterService.full_qualify_lawyer(lawyer)
        full_office << "Escritório: #{office.name.upcase}, "
        full_office << "OAB: #{office.oab}, "
        full_office << "CNPJ: #{office.cnpj_number}, "
        full_office << "Tipo: #{office.society}, "
        full_office << "E-mail: #{office.email}. " 
        full_office << "Advogado Responsável: #{lawyer}" 
        full_office
      end

      # --------------------------------------
      # office_templater(office, lawyer = nil, full_contract = nil)
      # will work around the office attributes and send fields
      # to the specific document 
      # obligatoly we need a lawyer responsible: "Advogado Responsável:"
      # the lawyer must be selected as an argument 
      # --------------------------------------
      
      def office_templater_lawyer_first(office, lawyer = nil, full_contract = nil)
        full_office = [].reject(&:blank?).join(', ')
        full_office << "#{Templater::TemplaterService.full_qualify_lawyer(lawyer)}" 
        full_office << "Integrante do Escritório: #{office.name.upcase}, "
        full_office << "OAB: #{office.oab}, "
        full_office << "CNPJ: #{office.cnpj_number}, "
        full_office << "Tipo: #{office.society}, "
        full_office << "E-mail: #{office.email}. " 
        full_office
      end

      # --------------------------------------
      # office_templater_lawyer_first(office, lawyer = nil, full_contract = nil)
      # this is used usually to procuration, where the lawyer comes first
      # and the office later
      # the reverse => office first, lawyer secondly, is for contracts 
      # --------------------------------------

      def office_templater_as_lawyer(lawyer)
        Templater::TemplaterService.full_qualify_lawyer(lawyer)
      end
      
      # --------------------------------------
      # office_templater_as_lawyer(lawyer)
      # Only repats the method into Templater::TemplaterService.full_qualify_lawyer(lawyer)
      # It will give the lawyer working alone (PF) the expected return 
      # to fill the document 
      # --------------------------------------

      # =-=-=-=-=-=-=-=-=-=-=-=-=- ENDS =-=-=-=-=-=-=-=-=-=-=-=-=-

    end

  end

end
