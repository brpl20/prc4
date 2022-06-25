class Tributary < ApplicationRecord
  belongs_to :work
  has_many :perd_launches, dependent: :destroy
end
