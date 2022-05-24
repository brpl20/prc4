class Bank < ApplicationRecord
  has_one :client, dependent: :destroy
  #before_save :fill_if_nil
  #retirado fill_if_nill porque como faz referencia ele fica vazio por padrao

  # Retirar NIL
  NULL_ATTRS = %w(name agency account)

protected

def fill_if_nil
  NULL_ATTRS.each { |attr| self[attr] = "[Campo Vazio]" if self[attr].nil? }
end

end
