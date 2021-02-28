class Client < ApplicationRecord
  has_many :phones, inverse_of: :client, dependent: :destroy
  has_many :emails, inverse_of: :client, dependent: :destroy

  has_many :client_works
  has_many :works, through: :client_works

  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true

  # Retirar NIL
  NULL_ATTRS = %w( lastname email bank)
  before_save :fill_if_nil

  protected

  def fill_if_nil
    NULL_ATTRS.each { |attr| self[attr] = "[Campo Vazio]" if self[attr].nil? }
  end

end
