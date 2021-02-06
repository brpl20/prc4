class Work < ApplicationRecord
  has_and_belongs_to_many :clients
  accepts_nested_attributes_for :clients, reject_if: :all_blank, allow_destroy: true
end
