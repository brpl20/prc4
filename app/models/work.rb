class Work < ApplicationRecord
  has_many :client_works
  has_many :clients, through: :client_works

  accepts_nested_attributes_for :client_works, reject_if: :all_blank, allow_destroy: true

end
