class Client < ApplicationRecord
  has_many :phones, inverse_of: :client, dependent: :destroy
  has_many :emails
  has_and_belongs_to_many :works
  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
end
