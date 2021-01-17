class Client < ApplicationRecord
  has_many :phones, inverse_of: :client
  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
end
