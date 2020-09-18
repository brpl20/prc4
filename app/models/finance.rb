class Finance < ApplicationRecord
  has_many :works, :through => :clients
  has_many :clients
  accepts_nested_attributes_for :works, :clients
end
