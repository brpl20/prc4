class Bank < ApplicationRecord
  belongs_to :client, dependent: :destroy
  before_save :fill_if_nil

  # Retirar NIL
  NULL_ATTRS = %w(name agency account)

protected

def fill_if_nil
  NULL_ATTRS.each { |attr| self[attr] = "[Campo Vazio]" if self[attr].nil? }
end

end