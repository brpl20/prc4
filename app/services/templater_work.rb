module TemplaterWork

  class TemplaterWorkService

    class << self

      def work_proceds(work)
        proceds = [].join("")
        work.procedures.each do | des |
          proceds << des.description
        end
        proceds 
      end

      def work_powers(work)
        powerxx = [].join("")
        work.powers.each do | pw |
          if pw.equal?(work.powers.last)
            powerxx << pw.description
          else
            powerxx << pw.description
          end
        end
        powerxx
      end


      def rater(work)
        # extenso = "R$ #{trabalho},00 (#{Extenso.moeda(trabalho.to_f).downcase})"
        # limpar e transformar 
        if work.rate_work == "Trabalho"
          return "o cliente pagará ao advogado o valor de #{work.rate_fixed_exfield}"
        elsif work.rate_work == "Êxito"
          return "o cliente pagará ao advogado o valor de #{work.rate_percentage_exfield}\% sobre os benefícios advindos do processo"
        elsif work.rate_work == "Ambos"
          return "o cliente pagará ao advogado o valor de #{work.rate_fixed_exfield} e o total de #{work.rate_percentage_exfield}\% dos benefícios advindos do processo"
        elsif work.rate_work == "Pro-bono"
          return "o contrato é realizado na modalidade 'Pro-Bono', ou seja, sem custo contratual para o contratante"
        else
          return "[erro ao selecionar o valor dos honorários]"
        end
      end

      def rate_parcel(work)
        if work.rate_parceled == "Sim"
          return ". O valor fixo poderá ser parcelado em #{work.rate_parceled_exfield}, a critério do cliente."
        else
          return "[configurar parcelamento]"
        end
      end

      def paralegals(work)
        #full_qualify_person(client
        Templater::TemplaterService.full_qualify_lawyer(UserProfile.find_by_id(work.procuration_paralegal))
      end
      
      # Dot vs Coma for pluralize 
      # paralegals.each_with_index do | x, index |
      #   if index == paralegals.size-1
      #     parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      #   else
      #     parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      #   end
      # end


      def interns(work)
        Templater::TemplaterService.full_qualify_lawyer(UserProfile.find_by_id(work.procuration_intern))
      end 
      
      # ???????????????
      # como combinar ? 
      # >> @work.clients.ids
      #   => [106]
      # >> @work.clients.ids.class
      #   => Array
      # >>
      # Templater::TemplaterService.full_qualify_person(client)
      # def full_qualify_person(client, full_contract = nil)
      #   gender = gender_check(client.gender)
      #   full = []
      #   full << full_name(client).upcase
      #   full << genderize(gender, client.civilstatus).downcase
      #   full << genderize(gender, client.citizenship).downcase
      #   full << client.capacity.downcase if client.capacity_check == false
      #   full << client.profession.downcase
      #   full << general_register_check(gender, client)
      #   full << social_number_check(gender, client)
      #   full << number_benefit_check(client)
      #   full << nit_check(gender, client)
      #   full << email_check(client)
      #   full << mothername_check(client) if full_contract == :full
      #   full << bank_check(client) if full_contract == :full
      #   full << client_address(gender, client)
      #   full << full_qualify_representative(client) if client.capacity_check == false
      #   full.reject(&:blank?).join(', ')
      # end
  
      def work_client_finder(work)
        client = [].reject(&:blank?).join(', ')
        work.clients.each do | cli |
          client << Templater::TemplaterService.full_qualify_person(Client.find_by_id(cli.id))
        end
        client
      end
      
      def work_office_finder(work)
        office = [].reject(&:blank?).join(', ')
        work.offices.each do | off |
          office << TemplaterOffice::TemplaterOfficeService.full_qualify_lawyer_of_office(Office.find_by_id(off.id))
        end
        office
      end

      class Array
        def csj # clean string join 
          self.reject(&:blank?).join(', ')
        end
      end
      #end


      def work_office_search(work)
        offices = []
        office_contract = [].reject(&:blank?).join(', ')
        work.offices.each do | off |
          offices << off.id
        end
        
        if offices.size > 1 
          offices.each do | off |
            office_contract << TemplaterOffice::TemplaterOfficeService.office_templater_lawyer_first(Office.find_by_id(off), UserProfile.find_by_id(work.user_id))
        end
          office_contract
          raise 
        end


      end


      # FULL CONTRACT 

      def client_data(work)
        work.each 
      end
      
      # #############################
      
      def replacer_work(work, doc)
        qualify = work_client_finder(work)
        office = TemplaterOffice::TemplaterOfficeService.office_grab
        dia = I18n.l(Time.now, format: "%d de %B de %Y")

        #paralegals = TemplaterOffice::TemplaterOfficeService.pralegals_grab
        # Por enquanto esta funcionando no modo 
        # Automatico, puxando apenas o Office.first
        procedures = work_proceds(work)
        powers = work_powers(work)
        #lawyers_proc = "TemplaterOffice::TemplaterOfficeService.office_templater_lawyer_first"
        
        # TODO - REVER PASSAGENS NO FORMULÁRIO PARA SELECIONAR O ADVOGADO RESPONSÁVEL PELO CONTRATO ! 
        offices = work_office_search(work)
        #raise
        
        #qualify_contract = "Templater::Templater:: :full"
        doc.paragraphs.each do |p|
          p.each_text_run do |tr|
            tr.substitute('_qualify_', qualify)
            tr.substitute('_lawyers_', office)
            tr.substitute('_:procedure_', procedures)
            tr.substitute('_:subject_', work.subject)
            tr.substitute('_:action_', work.action)
            tr.substitute('_:number_', work.number)
            tr.substitute('_:powers_', powers)
            tr.substitute('_lawyerscontract_', office)
            tr.substitute('_qualifycontract_', qualify)
            tr.substitute('_$parl_', paralegals(work))
            tr.substitute('$es', interns(work))
            tr.substitute('_:rates_', rater(work))
            tr.substitute('_:parcel_', rate_parcel(work))
            tr.substitute('_:timestamp_', dia)
          end
        end
        doc
      end 

    
      
      #rate_parceled_final = rate_parcel(work)
      #<Work id: 61, subject: "Trabalhista", action: "Reclamatória Trabalhista", number: "561", rate_percentage: "Campo Vazio", rate_percentage_exfield: "25", rate_fixed: "Campo Vazio", rate_fixed_exfield: "1", rate_work: "Ambos", rate_parceled: "Não", power: "Campo Vazio", folder: "Et at dolor vel mole", initial_atendee: "4", procuration_lawyer: "Campo Vazio", procuration_intern: "3", procuration_paralegal: "5", partner_lawyer: "Aut non exercitation", note: "Consequat Molestias", checklist: "Campo Vazio", checklist_document: "Campo Vazio", document_pendent: "Et et pariatur Veli", user_id: 2, created_at: "2022-10-10 21:17:53.886772000 -0300", updated_at: "2022-10-10 21:17:53.886772000 -0300", document: nil, rate_parceled_exfield: "Adipisci sit ad minu">
      ########################
    end

  end

end


