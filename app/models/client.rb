# frozen_string_literal: true

class Client < ApplicationRecord
  has_one :bank, dependent: :destroy
  has_many :phones, inverse_of: :client, dependent: :destroy
  has_many :emails, inverse_of: :client, dependent: :destroy
  has_many :customer_types, inverse_of: :client, dependent: :destroy

  has_many :client_works, dependent: :destroy
  has_many :works, through: :client_works
  has_many :jobs
  has_many_attached :files
  has_many :recommendation_works, dependent: :destroy

  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :customer_types, reject_if: :all_blank, allow_destroy: true

  validates :name, :lastname, :social_number, :gender, :civilstatus, :citizenship, :capacity, :birth, :phones, :emails,
            :address, :city, :state, :profession, presence: true, if: proc { |c| c.client_type.zero? }

  validates :phones, :emails, :address, :city, :state, presence: true, if: proc { |c| c.client_type == 1 }

  validates :name, :lastname, :phones, :emails, :social_number, presence: true, if: proc { |c| c.client_type == 2 }

  validates :name, :lastname, :phones, :emails, presence: true, if: proc { |c| c.client_type == 3 }

  validate :file_type

  DESCRIPTION = %w[Representante\ Legal Contador].freeze

  NULL_ATTRS = %w[lastname bank email].freeze
  # before_save :fill_if_nil, :default_values


  def gender_check(client)
    if client === 0
      gender = :male
    else
      gender = :female
    end
  end

  def self.can_be_destroyed id
    ClientWork.exists?(client_id: id)
  end

  def full_name(client)
    [client.name,client.lastname].join(' ')
  end

  def zero?
    self == 0
  end


  def full_qualify_person(client, full_contract=nil)
    gender = gender_check(client.gender)
    full = []
    full << full_name(client).upcase
    full << genderize(gender, client.civilstatus).downcase
    full << genderize(gender, client.citizenship).downcase
    full << client.capacity.downcase if client.capacity_check === false
    full << client.profession.downcase
    full << general_register_check(gender, client)
    full << social_number_check(gender, client)
    full << number_benefit_check(client)
    full << nit_check(gender, client)
    full << email_check(client)
    full << mothername_check(client) if full_contract === :full
    full << bank_check(client) if full_contract === :full
    full << client_address(gender, client)
    full << full_qualify_representative(client) if client.capacity_check === false
    full.reject(&:blank?).join(", ")
    raise
  end

  # criar método para qualificar compania
  def full_qualify_company(client);end

  # :full contract methods

  def email_check(client)
    email_details = "endereço eletrônico: " + emails.map(&:email)[0]
    # deixar email obrigatório para não dar problema com nil
  end

  def mothername_check(client)
    "nome da mãe #{client.mothername}"
  end

  def bank_check(client)
    banks_helper = ApplicationController.helpers.options_for_banks
    bank_details = "Dados Bancários: Banco #{banks_helper.select {|item| item.include?("#{client.bank.name}")}[0][1]} (#{client.bank.name}), Agência: #{client.bank.agency}, Conta: #{client.bank.account}"
  end

  # representative methods

  def full_qualify_representative(client)
    full_rep = [].reject(&:blank?).join(", ")
    unless client.customer_types.nil?
      full_rep = ["Representado por"]
      client.customer_types.each do |ct|
        retrieve_represented(ct.represented)
          rep = Client.find_by_id(ct.represented)
          full_rep << full_name(rep).upcase
          full_rep << genderize(gender, rep.civilstatus).downcase
          full_rep << genderize(gender, rep.citizenship).downcase
          full_rep << rep.profession.downcase
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
  # Testar com 2 representantes
  # Empresas
  # Office


  def number_benefit_check(client)
    if client.number_benefit.nil? || client.number_benefit == ""
      nb_not_exist = ""
    else
      nb_exist = "nº de benefício #{client.number_benefit}"
    end
  end

  def general_register_check(gender, client)
    if client.general_register.nil? || client.general_register == ""
      general_register_not_exist = ""
    else
      if gender == :female
        general_register_exist = "portadora do RG nº #{client.general_register}"
      else
        general_register_exist = "portador do RG nº #{client.general_register}"
      end
    end
  end

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

  def nit_check(gender, client)
    if client.nit.nil? || client.nit == ""
      nit_not_exist = ""
    else
      if gender == :female
        nit_exist = "nº de inscrição da trabalhadora - NIT: #{client.nit}"
      else
        nit_exist = "nº de inscrição do trabalhador - NIT: #{client.nit}"
      end
    end
  end


  def capacity_check
    if self.capacity == "Capaz"
      true
    else
      false
    end
  end

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

  def genderize(gender, civilstatus)
    if gender === :female
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


  # def genderize_words(gender)
  #   if gender == 1
  #     words = { "porta" => "portadora", "ins" => "Inscrita", "dom" => "domiciliada" }
  #     @inscrito = "inscrita"
  #     @domiciliado = "domiciliada"
  #   else
  #     @porta = "portador"
  #     @inscrito = "inscrito"
  #     @domiciliado = "domiciliado"
  #   end
  # end


  protected

  def file_type
    files.each do |file|
      unless file.content_type.in?(%{'image/jpeg image/png application/pdf'})
        errors.add(:files, 'apenas são permtidos nos formatos JPG, PNG ou PDF.')
      end
    end
  end

  def fill_if_nil
    NULL_ATTRS.each { |attr| self[attr] = '[Campo Vazio]' if self[attr].nil? }
  end

  def retrieve_represented(id)
    id ? Client.find(id).name : 'não informado'
  end

end
