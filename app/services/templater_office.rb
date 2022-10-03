module TemplaterOffice

  class TemplaterOfficeService

    class << self

      # Office check for pf or multi offices
      # 
      def office_check(office_id)
        if office_id.society = "Pessoa física"
          office_pf(office_id)
        else
          office_pj(office_id)
        end
      end

      # use this for generate offices related to clients method
      # Templater Templater::TemplaterService
      def generic_office_for_all
        
      end 

      def full_qualify_one_office_for_work(work)
        offices = [].join(', ')
        offices << office_templater(Office.find_by_id(work.work_offices[0].office_id)).join(', ')
        offices
      end

      def full_qualify_multiple_offices(office_id)
      end

      def full_qualify_office_pf(office_id)
      end

      def office_templater(office)
        full_office = [].reject(&:blank?).join(', ')
        full_office = ["Escritório: "]
        full_office << office.name
        full_office << "OAB: #{office.oab}"
        full_office << "CNPJ: #{office.cnpj_number}"
        full_office << "Tipo: #{office.society}"
        full_office << "Tipo: #{office.email}"
        full_office
      end 



      def office_pf(office_id)
      end

      def office_pf(office_id)
      end





    end

  end

end
