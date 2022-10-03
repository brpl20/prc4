# frozen_string_literal: true

class CustomerClient < ApplicationRecord
  belongs_to :client
  belongs_to :customer
end
