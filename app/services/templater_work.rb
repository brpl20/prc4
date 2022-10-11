module TemplaterWork

  class TemplaterWorkService

    class << self

      def work_proceds(work)
        proceds = [].join("")
        work.procedures.each do | des |
          proceds << des.description
        end
      end

      def work_powers(work)
        powerxx = [].join("")
        work.powers.each do | pw |
          if pw.equal?(work.powers.last)
            powerxx << "#{JSON.parse(pw.description)[1]}."
          else
            powerxx << "#{JSON.parse(pw.description)[1]}, "
          end
        end
      end


      def rater(work)
        
        # extenso = "R$ #{trabalho},00 (#{Extenso.moeda(trabalho.to_f).downcase})"
        # limpar e transformar 

        if work.rate_work == "Trabalho"
          return "o cliente pagará ao advogado o valor de #{work.rate_fixed_exfield}"
        elsif work.rate_work == "Êxito"
           return "o cliente pagará ao advogado o valor de #{work.rate_percentage_exfield}\% sobre os benefícios advindos do processo"
         else
          return "o cliente pagará ao advogado o valor de #{work.rate_fixed_exfield} e o total de #{work.rate_percentage_exfield}\% dos benefícios advindos do processo"
        end
      end

      def rate_parcel(work)
        if work_parcel.rate_parceled == "Sim"
          return ". O valor fixo poderá ser parcelado em #{work.rate_parceled_exfield}, a critério do cliente."
        else
          return "[configurar parcelamento]"
        end
      end
      
      # ???????????????

      def client_bank
        bank = ". Dados bancários: Banco: #{client.bank.name}, Agência #{client.bank.agency}, Conta: #{client.bank.account}"
      end

      def client_data
      end
      
      # #############################


      def replacer
        doc = Docx::Document.open(aws_body)
        doc.paragraphs.each do |p|
          p.each_text_run do |tr|
            tr.substitute('_:nome_', nome_cap)
            tr.substitute('_:sobrenome_', sobrenome_cap)
            tr.substitute('_:estado_civil_', civilstatus.downcase)
            tr.substitute('_:profissao_', client.profession.downcase)
            tr.substitute('_:capacidade_', capacity_treated.downcase)
            tr.substitute('_:nacionalidade_', nacionalita.downcase)
            tr.substitute('_:rg_', client.general_register)
            tr.substitute('_:cpf_', client.social_number.to_s)
            tr.substitute('_:nb_', nb_exist)
            tr.substitute('_:email_', emails)
            tr.substitute('_:phone_', phones)
            tr.substitute('_:endereco_', client.address)
            tr.substitute('_:cidade_', client.city)
            tr.substitute('_:state_', client.state)
            tr.substitute('_:cep_', client.zip.to_s)
            tr.substitute('_:empresa_atual_', client.company)
            tr.substitute('_:banco_', bank)
    
            tr.substitute('_:lawyers_', laws)
            tr.substitute('_:society_', office)
            tr.substitute('_:lawyerresponsible_',  @work.user[:name].to_s)
    
            tr.substitute('_:portador_', porta)
            tr.substitute('_:inscrito_', inscrito)
            tr.substitute('_:domiciliado_', domiciliado)
    
             tr.substitute('_:procedure_', proceds)
             tr.substitute('_:subject_', work.subject)
             tr.substitute('_:action_', work.action)
             tr.substitute('_:number_', work.number)
             tr.substitute('_:powers_', powerxx)
    
             tr.substitute('_:lawyers_', laws)
             tr.substitute('_:sociedade_', office)
             tr.substitute('_$parl_', parals)
             tr.substitute('$es', inters)
             tr.substitute('_:addressoficial_', office_address)
             # tr.substitute('_:emailoficial_', office_email)
             #tr.substitute('_:prev-powers_', "")
    
            tr.substitute('_:rates_', rate_final)
            tr.substitute('_:parcel_', rate_parceled_final)
            tr.substitute('_:accountdetails_', office_bank)
    
            tr.substitute('_:timestamp_', dia)
            tr.substitute('_:sname_', office_sel.name.upcase)
            tr.substitute('_:fullqual_', fullqual(client))
          end
      end
      
      #rate_parceled_final = rate_parcel(work)
      #<Work id: 61, subject: "Trabalhista", action: "Reclamatória Trabalhista", number: "561", rate_percentage: "Campo Vazio", rate_percentage_exfield: "25", rate_fixed: "Campo Vazio", rate_fixed_exfield: "1", rate_work: "Ambos", rate_parceled: "Não", power: "Campo Vazio", folder: "Et at dolor vel mole", initial_atendee: "4", procuration_lawyer: "Campo Vazio", procuration_intern: "3", procuration_paralegal: "5", partner_lawyer: "Aut non exercitation", note: "Consequat Molestias", checklist: "Campo Vazio", checklist_document: "Campo Vazio", document_pendent: "Et et pariatur Veli", user_id: 2, created_at: "2022-10-10 21:17:53.886772000 -0300", updated_at: "2022-10-10 21:17:53.886772000 -0300", document: nil, rate_parceled_exfield: "Adipisci sit ad minu">
      ########################
    end

  end

end


