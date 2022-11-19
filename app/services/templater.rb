module Templater

  class TemplaterService

    class << self

      def gender_check(client)
        if client === 0
          gender = :male
        else
          gender = :female
        end
      end

      # --------------------------------------
      # gender_check 
      # Check if client is male or female 
      # use only with PF (persons) clients
      # don't use with CNPJ (companies) clients 
      # --------------------------------------

      def genderize(gender, civilstatus)
        if gender == :female
          case civilstatus
            when "Casado"
              civilstatus.sub! 'Casado', 'Casada'
            when "Solteiro"
              civilstatus.sub! 'Solteiro', 'Solteira'
            when "Divorciado"
              civilstatus.sub! 'Divorciado', 'Divorciada'
            when "Viúvo"
              civilstatus.sub! 'Viúvo', 'Viúva'
            when "Brasileiro"
              civilstatus.sub! 'Brasileiro', 'Brasileira'
            when "Estrangeiro"
              civilstatus.sub! 'Estrangeiro', 'Estrangeira'
            else
            "em União Estável"
          end
        else
          civilstatus
        end
      end

      # --------------------------------------
      # genderize 
      # after male/female checking 
      # we will use the correct pronoums to the treatment 
      # use only with PF (persons) clients
      # don't use with CNPJ (companies) clients 
      # --------------------------------------

      def self.can_be_destroyed id
        ClientWork.exists?(client_id: id)
      end

      # --------------------------------------
      # can_be_destroyed 
      # 
      # --------------------------------------

      def full_name(client)
        [client.name,client.lastname].join(' ')
      end

      # --------------------------------------
      # full_name 
      # simple join first and last name 
      # --------------------------------------

      def email_check(client)
        email_details = "endereço eletrônico: #{client.emails.map(&:email)[0]}"
      end

      # --------------------------------------
      # email_check 
      # templater/filler
      # --------------------------------------

      def mothername_check(client)
        "nome da mãe #{client.mothername}"
      end

      # --------------------------------------
      # mothername_check 
      # templater/filler
      # --------------------------------------

      def bank_check(client)
        banks_helper = ApplicationController.helpers.options_for_banks
        bank_details = "Dados Bancários: Banco #{banks_helper.select { |item| item.include?("#{client.bank.name}")}[0][1]} (#{client.bank.name}), Agência: #{client.bank.agency}, Conta: #{client.bank.account}"
      end

      # --------------------------------------
      # bank_check 
      # templater/filler
      # --------------------------------------

      def number_benefit_check(client)
        if client.number_benefit.nil? || client.number_benefit == ""
          nb_not_exist = ''
        else
          nb_exist = "nº de benefício #{client.number_benefit}"
        end
      end

      # --------------------------------------
      # number_benefit_chekc
      # templater/filler
      # --------------------------------------

      def general_register_check(gender, client)
        if client.general_register.nil? || client.general_register == ""
          general_register_not_exist = ''
        else
          if gender == :female
            general_register_exist = "portadora do RG nº #{client.general_register}"
          else
            general_register_exist = "portador do RG nº #{client.general_register}"
          end
        end
      end

      # --------------------------------------
      # general_register_check
      # templater/filler
      # --------------------------------------

      def social_number_check(gender,client)
        if client.social_number.nil? || client.social_number == ""
          social_number_not_exist = ""
        else
          if gender == :female
            social_number_exist = "inscrita sob o CPF nº #{client.social_number}"
          else
            social_number_exist = "inscrito sob o CPF nº #{client.social_number}"
          end
        end
      end

      # --------------------------------------
      # social_number_check
      # templater/filler
      # --------------------------------------
  
      def nit_check(gender, client)
        if client.nit.nil? || client.nit == ''
          nit_not_exist = ''
        else
          if gender == :female
            nit_exist = "nº de inscrição da trabalhadora - NIT: #{client.nit}"
          else
            nit_exist = "nº de inscrição do trabalhador - NIT: #{client.nit}"
          end
        end
      end

      # --------------------------------------
      # nit_check
      # templater/filler
      # --------------------------------------

      def capacity_check
        if self.capacity == "Capaz"
          true
        else
          false
        end
      end

      # --------------------------------------
      # capacity_check
      # templater/filler
      # --------------------------------------

      def client_address(gender, client)
        if client.zip.blank?
          if gender == :female
            client_with_out_zip = "residente e domiciliada à #{client.address}, #{client.city}, #{client.state}."
          else
            client_with_out_zip = "residente e domiciliado à #{client.address}, #{client.city}, #{client.state}."
          end
        else
          if gender == :female
            client_with_zip = "residente e domiciliada à #{client.address}, #{client.city}, #{client.state}, CEP: #{client.zip}."
          else
            client_with_zip = "residente e domiciliado à #{client.address}, #{client.city}, #{client.state}, CEP: #{client.zip}."
          end
        end
      end

      # --------------------------------------
      # client_address
      # templater/filler
      # --------------------------------------

      def full_qualify_person(client, full_contract = nil)
        gender = gender_check(client.gender)
        full = []
        full << full_name(client).upcase
        full << genderize(gender, client.civilstatus).downcase
        full << genderize(gender, client.citizenship).downcase
        full << client.capacity.downcase if client.capacity_check == false
        #full << client.profession.downcase
        full << general_register_check(gender, client)
        full << social_number_check(gender, client)
        full << number_benefit_check(client)
        full << nit_check(gender, client)
        full << email_check(client)
        full << mothername_check(client) if full_contract == :full
        full << bank_check(client) if full_contract == :full
        full << client_address(gender, client)
        full << full_qualify_representative(client) if client.capacity_check == false
        full.reject(&:blank?).join(', ')
      end

      # --------------------------------------
      # full_qualify_person
      # to full qualify one person (PF)
      # --------------------------------------

      def full_qualify_lawyer(lawyer, full_contract = nil)
        gender = gender_check(lawyer.gender)
        full = []
        full << full_name(lawyer).upcase
        full << genderize(gender, lawyer.civilstatus).downcase
        full << genderize(gender, lawyer.citizenship).downcase
        full << general_register_check(gender, lawyer)
        full << social_number_check(gender, lawyer)
        full << client_address(gender, lawyer)
        full.reject(&:blank?).join(', ')
      end

      # --------------------------------------
      # full_qualify_lawyer
      # to full qualify one lawyer
      # --------------------------------------

      def full_qualify_representative(client)
        full_rep = [].reject(&:blank?).join(', ')
        unless client.customer_types.nil?
          full_rep = ["Representado por"]
          gender = gender_check(client.gender)
          client.customer_types.each do |ct|
              rep = Client.find_by_id(ct.represented)
              full_rep << full_name(rep).upcase
              #full_rep << genderize(gender, rep.civilstatus).downcase
              #full_rep << genderize(gender, rep.citizenship).downcase
              #full_rep << rep.profession.downcase
              full_rep << general_register_check(gender, rep)
              full_rep << social_number_check(gender, rep)
              full_rep << number_benefit_check(rep)
              full_rep << nit_check(gender, rep)
              full_rep << client_address(gender, rep)
              full_rep
            end
          full_rep
        end
      end

      # --------------------------------------
      # full_qualify_representative
      # to full qualify representatives 
      # todo fix civilstatus / citizenship / profession 
      # --------------------------------------

      def cnpj_check(client)
        if client.social_number.nil? || client.social_number == ""
          cnpj_number_not_exist = "[favor preencher o CNPJ da empresa]"
        else
          cnpj_number_exist = "pessoa jurídica de direito privado, inscrita sob o CNPJ nº #{client.social_number}"
        end
      end 

      def full_qualify_company(client, full_contract: nil)
        #raise
        full = []
        full << client.name
        full << cnpj_check(client)
        full << full_qualify_representative(client)
        full << email_check(client)
        full << "com sede à #{client.address}"
        full << bank_check(client) if full_contract == :full
        full.reject(&:blank?).join(', ')
      end 

      def replacer(client, doc)
        doc.paragraphs.each do |p|
          p.each_text_run do |tr|
            dia = I18n.l(Time.now, format: "%d de %B de %Y")
            if client.client_type == 1
              ql = full_qualify_company(client) # qualification of clients as company (CNPJ)
              #raise 
            else 
              #raise 
              ql = full_qualify_person(client)                              # ql => qualify => to use all data do know who it is
                                                                            # qualification of persons - clients (PF) 
            end
            lawyer = full_qualify_lawyer(UserProfile.first)
            office = TemplaterOffice::TemplaterOfficeService.office_check 
            # TemplaterOffice::TemplaterOfficeService.office_templater_procuration(Office.first).reject(&:blank?).join(', ')
            tr.substitute('_fn_', full_name(client).upcase) 
            tr.substitute('_timestamp_', dia+".")
            tr.substitute('_qualify_', ql)
            tr.substitute('_lawyers_', lawyer)
          end
        end
        doc
      end

      # --------------------------------------
      # replacer 
      # to wrap all around and execute the 
      # desired replacements 
      # --------------------------------------

# Module CLASS kEEEP ENDs # 
    end
  end
end 



