class Bank < ApplicationRecord
  belongs_to :client, dependent: :destroy

  # Retirar NIL
  NULL_ATTRS = %w( name agency account)
  before_save :fill_if_nil


  protected

  def fill_if_nil
    NULL_ATTRS.each { |attr| self[attr] = "[Campo Vazio]" if self[attr].nil? }
  end





end
