class Client < ApplicationRecord
  has_one  :bank, dependent: :destroy
  has_many :phones, inverse_of: :client, dependent: :destroy
  has_many :emails, inverse_of: :client, dependent: :destroy

  has_many :client_works, dependent: :destroy
  has_many :works, through: :client_works
  has_many :jobs

  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true

  # Enum
  # https://naturaily.com/blog/ruby-on-rails-enum
  # Status: Active = 0 {Cliente Ativo}
  # Status: Inactive = 1 {Cliente Inativo}

  # Representante Legal: nao = 0 {Nao e representante legal}
  # Representante Legal: yes   = 1 {APENAS representante legal}
  # Representante Legal: both = 2 {É representante legal e TAMBÉM cliente}

  enum status: [:active, :inactive]
  # enum representative: [:no, :yes, :both]


  # Retirar NIL
  # NULL_ATTRS = %w( lastname email bank emails phones)
  NULL_ATTRS = %w( lastname bank)
  before_save :fill_if_nil, :default_values


  protected

  def default_values
    self.status = 0
  end


  def fill_if_nil
    NULL_ATTRS.each { |attr| self[attr] = "[Campo Vazio]" if self[attr].nil? }
  end

end
