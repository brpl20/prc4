module TemplaterOffice

  class TemplaterOfficeService

    class << self

      def full_qualify_office(work)
        if work.work_offices.count > 0.5
          offices = [].join(', ')
          work.work_offices.each do |wo|
            @selected_office = Office.find_by_id(wo.office_id)
            offices << office_templater(@selected_office).join(', ')
            return offices
          end
        end
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

      # OFFICE CHECK IF IS PES
      def office_check(office_id)
        if office_id.society = "Pessoa física"
          office_pf(office_id)
        else
          office_pj(office_id)
        end
      end

      def office_pf(office_id)

      end

      def office_pf(office_id)
      end





    end

  end

end
