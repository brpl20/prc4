module TemplaterOffice

  class TemplaterOfficeService

    class << self

      # Office check for pf or multi offices
      # 
      def office_check(office_id)
        #if work.work_offices.count > 0.5
        if office_id.society = "Pessoa física"
          office_pf(office_id)
        else
          office_pj(office_id)
        end
      end

      def full_qualify_one_office_for_work(work)
        offices = [].join(', ')
        offices << office_templater(Office.find_by_id(work.work_offices[0].office_id)).join(', ')
        offices
      end

      def full_qualify_multiple_offices(work)
        offices = [].join(', ')
        work.work_offices.map do |wo|
          selected_office = Office.find_by_id(wo.office_id)
          offices << office_templater(selected_office).join(', ')
        end
        offices
      end

      def full_qualify_office_pf(office_id)
        UserProfileFilters.by_role(0)
      end

      def office_templater(office)
        full_office = [].reject(&:blank?).join(', ')
        full_office = ["Escritório: "]
        full_office << office.name
        full_office << "OAB: #{office.oab}"
        full_office << "CNPJ: #{office.cnpj_number}"
        full_office << "Tipo: #{office.society}"
        full_office << "E-mail: #{office.email}"
        full_office
      end 
      
      # -------------------------------------------------------

      # use this for generate offices related to clients method
      # Templater Templater::TemplaterService
      def generic_office_for_all;end 

      # works_helper 
      # to help check if office really exist or we need the doc
      # used as a person  
      def office_exist?
        if Office.all.count > 0.5
          true
        else
          false
        end
      end
    
      # to select a lawyer without office
      def options_for_lawyers_without_office
        UserProfileFilters.by_role(0)
      end

    end

  end

end
