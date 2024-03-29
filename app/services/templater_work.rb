module TemplaterWork

  
# --------------------------------------
# Intro
# This is the place for dealing with Works
# They will generate the documents acording to  
# the desired work 
# they are also related to the office, the lawyer, and the client 
# work docs generally will create multiple docs 
# procuration => to the specific work
# contract => where we find the rules of the case between lawyer and client
# poverty declaration (declaracao de pobreza) => if the client has no money to pay legal taxes
# small cases declaration => to choose small cases litigation
# --------------------------------------


# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
# FUTURE
# We will have also, in the future 
# Legal clains (petitions)
# Apeals, and other forms of documents
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

  class TemplaterWorkService

    class << self

      def full_name(client)
        [client.name, client.lastname].join(' ')
      end

      def work_clients(work)
        clients = []
        work.clients.each do | cli |
          clients << full_name(cli)
          #raise
        end
        clients.join(", ")
        #raise
      end

      # --------------------------------------
      # just to return the fullname "fn"
      # --------------------------------------


      
      def work_proceds(work)
        work.procedures.map(&:description).reject(&:blank?).join(', ') + "."
      end    

      # --------------------------------------
      # works_proceds
      # proceds will work with `procedures` field 
      # to find out what kind of procedures will be required 
      # into the working doc
      # --------------------------------------


      def work_powers(work)
        work.powers.map(&:description).reject(&:blank?).join(', ') + "."
      end

      # --------------------------------------
      # work_powers 
      # this is what kind of representation a lawyer 
      # can get from his client 
      # each kind of work requires a specific amount of powers to do
      # a criminal case will require specific powers
      # a social secutiry case others 
      # this is also a form of protecting the client 
      # --------------------------------------


      def rater(work)
        # extenso = "R$ #{trabalho},00 (#{Extenso.moeda(trabalho.to_f).downcase})"
        # limpar e transformar 
        if work.rate_work == "Trabalho"
          #text = work.rate_fixed_exfield
          #sentences = Extenso.moeda(text.to_f)
          #raise
          return "o cliente pagará ao advogado o valor de #{work.rate_fixed_exfield}"
        elsif work.rate_work == "Êxito"
          return "o cliente pagará ao advogado o valor de #{work.rate_percentage_exfield} sobre os benefícios advindos do processo"
        elsif work.rate_work == "Ambos"
          return "o cliente pagará ao advogado o valor de #{work.rate_fixed_exfield} e o total de #{work.rate_percentage_exfield}\% dos benefícios advindos do processo"
        elsif work.rate_work == "Pro-bono"
          return "o contrato é realizado na modalidade 'Pro-Bono', ou seja, sem custo contratual para o contratante"
        else
          return "[erro ao selecionar o valor dos honorários]"
        end
      end

      # # INPUTS 
      # R$ 2.000,00
      # 2.000
      # 2000
      # 4 benefícios previdenciários 


      # # REAL DEAL 
      # rate_work: "Ambos"
      # rate_percentage: nil, 
      # rate_percentage_exfield: "30% ",
      # rate_fixed: nil,
      # rate_fixed_exfield: "4 benefícios ", 
      # rate_work: "Ambos", 
      # rate_parceled: "Sim", 


      # --------------------------------------
      # rater 
      # will work around the form of payment to the lawyer 
      # usually we have three forms 
      # working (work) => lawyer receives R$ xxx for the job regardless of the result 
      # success (exito) => lawyer receives % for the jog depending of the final result 
      # both (mix between work and success)
      # ** keep in mind that rate_percentage and rate_fixed are not useful, all the logic is **
      # ** done with rate_work **
      # pro bono => Free 
      # --------------------------------------

      
      def rate_parcel(work)
        if work.rate_parceled == "Sim"
          return ". O valor fixo poderá ser parcelado em #{work.rate_parceled_exfield}, a critério do cliente."
        else
          return "[configurar parcelamento]"
        end
      end

      # --------------------------------------
      # rate_parccel 
      # lawyer can fix an easy form of payment 
      # like, 10 times of 1.000,00 instead of 1 time of 10.000,00
      # -------------------------------------- 

      def paralegals(work)
        #full_qualify_person(client
        Templater::TemplaterService.full_qualify_lawyer(UserProfile.find_by_id(work.procuration_paralegal))
      end

      # --------------------------------------
      # paralegals 
      # in our system we have the possibility to create documents 
      # including the paralegals 
      # this is important because they already have the power to 
      # assist the lawyer into non exclusive lawyer services 
      # --------------------------------------
      
      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 
      # Todo - keep this method example until fixed totally
      # Dot vs Coma for pluralize 
      # paralegals.each_with_index do | x, index |
      #   if index == paralegals.size-1
      #     parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}.".to_s
      #   else
      #     parals << "#{x.name} #{x.lastname}, RG #{x.general_register}, CPF #{x. social_number}, #{x.civilstatus}, ".to_s
      #   end
      # end
      # -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

      def interns(work)
        Templater::TemplaterService.full_qualify_lawyer(UserProfile.find_by_id(work.procuration_intern))
      end 

      # --------------------------------------
      # interns 
      # similar to paralegals 
      # in our system we have the possibility to create documents 
      # including the interns 
      # this is important because they already have the power to 
      # assist the lawyer into non exclusive lawyer services 
      # --------------------------------------

      def work_client_finder(work)
        client = [].reject(&:blank?).join(', ')
        work.clients.each do | cli |
          client << Templater::TemplaterService.full_qualify_person(Client.find_by_id(cli.id))
        end
        client
      end

      # --------------------------------------
      # work_client_finder 
      # helper to find and qualify the client 
      # that belongs to the selected work
      # --------------------------------------

      def work_office_finder(work)
        office = [].reject(&:blank?).join(', ')
        work.offices.each do | off |
          office << TemplaterOffice::TemplaterOfficeService.full_qualify_lawyer_of_office(Office.find_by_id(off.id))
        end
        office
      end

      def work_office_finder_new(work)
        work.offices.map(&:id)
      end

      # --------------------------------------
      # work_office_finder  
      # helper to find and qualify the client 
      # that belongs to the selected work
      # --------------------------------------

      def csj # clean string join 
        reject(&:blank?).join(', ')
      end
      
      # --------------------------------------
      # csj
      # todo: pending method
      # 
      # --------------------------------------

      def work_office_search_for_procuration(work)
        offices = []
        office_contract = [].reject(&:blank?).join(', ')
        work.offices.each do | off |
          offices << off.id
          #raise
        end
        if offices.size > 1 
          offices.each do | off |
            office_contract << TemplaterOffice::TemplaterOfficeService.office_templater_lawyer_first(Office.find_by_id(off), UserProfile.find_by_id(work.user_id))
            #raise
        end
        else 
          office_contract << TemplaterOffice::TemplaterOfficeService.office_templater_lawyer_first(Office.find_by_id(offices[0]), UserProfile.find_by_id(work.user_id))
            #raise
        end
      end

      # --------------------------------------
      # work_office_search 
      # methodo to 
      # helper to find the office related to specific work 
      # --------------------------------------

      def replacer_work(work, doc)
        qualify = work_client_finder(work)
        office = TemplaterOffice::TemplaterOfficeService.office_grab
        dia = I18n.l(Time.now, format: "%d de %B de %Y")

        #paralegals = TemplaterOffice::TemplaterOfficeService.pralegals_grab
        # Por enquanto esta funcionando no modo 
        # Automatico, puxando apenas o Office.first
        procedures = work_proceds(work)
        powers = work_powers(work)
        lawyers_proc = work_office_search_for_procuration(work)
        #raise
        full_names = work_clients(work)
        # TODO - REVER PASSAGENS NO FORMULÁRIO PARA SELECIONAR O ADVOGADO RESPONSÁVEL PELO CONTRATO ! 
        #offices = work_office_search(work)
        #raise
        
        #qualify_contract = "Templater::Templater:: :full"
        doc.paragraphs.each do |p|
          p.each_text_run do |tr|
            tr.substitute('_qualify_', qualify)
            tr.substitute('_lawyers_', office)
            tr.substitute('_:procedure_', procedures)
            tr.substitute('_:subject_', work.subject)
            tr.substitute('_fn:_', full_names)
            tr.substitute('_:action_', work.action)
            tr.substitute('_:number_', work.number)
            tr.substitute('_:powers_', powers)
            tr.substitute('_:lbs:_', lawyers_proc)
            tr.substitute('_lawyerscontract_', office)
            #raise
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


