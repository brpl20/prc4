class Bank < ApplicationRecord
  belongs_to :client, dependent: :destroy
end
