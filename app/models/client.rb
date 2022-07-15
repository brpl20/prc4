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

  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :customer_types, reject_if: :all_blank, allow_destroy: true

  validate :file_type

  DESCRIPTION = %w[Representante\ Legal Contador].freeze

  NULL_ATTRS = %w[lastname bank].freeze
  # before_save :fill_if_nil, :default_values

  def self.can_be_destroyed id
    ClientWork.exists?(client_id: id)
  end

  def full_name(client)
    [client.name,client.lastname].join(' ')
  end

  def full_qualify(client)
    # nome-sobrenome - nacionalidade - estado civil - rg, cpf
    civilstatus_gender_correction = client.gender ? genderize(client.civilstatus) : client.civilstatus
    full = []
    full << [client.name, client.lastname].join(' ').upcase
    full << client.citizenship.downcase
    full << civilstatus_gender_correction.downcase
    full << client.profession
    full << client.general_register # portador / portadora do rg ...
    full << client.social_number # inscrita / inscrito no CPF sob n arrumar NIL
    full << number_benefit_check(client) # numero de beneficio
    full << client.nit
    full << client_address(client)
    representante = full_qualify_representative(client)
    full << representante
    full
  end

  def full_qualify_contract(client)
    full = full_qualify
    # full << email
    # full << telefone
    # full << nome da mae
    # full << dados bancários para contrato também
  end

  def full_qualify_representative(client)
    full_rep = []
    unless client.customer_types.nil?
      full_rep = [client.capacity] + ["Representado por "]
      client.customer_types.each do |ct|
        retrieve_represented(ct.represented)
        full_rep << full_qualify(Client.find_by_id(ct.represented))
      end
      full_rep.join(",")
      raise
    end
  end


  def number_benefit_check(client)
    if client.number_benefit.nil? || client.number_benefit == ""
      nb_exist = ""
    else
      nb_exist = "número de benefício #{client.number_benefit}, "
    end
  end

  def capacity_check(client)
    if client === "Capaz"
      return true
    else
      return false
    end
  end

  def client_address(client)
    client.zip ? "Residente e domiciliado à #{client.address}, #{client.city}, #{client.state}, CEP: #{client.zip}." : "Residente e domiciliado à #{client.street}, #{client.city}, #{client.state}."
  end

  def genderize(civilstatus)
    case civilstatus
    when "Casado"
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
  # def default_values
  #  self.status = 0
  # end

  def file_type
    files.each do |file|
      unless file.content_type.in?(%{'image/jpeg image/png application/pdf'})
        errors.add(:files, 'Adicione um arquivo JPG, PNG ou PDF.')
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
