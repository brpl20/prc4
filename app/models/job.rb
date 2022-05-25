# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :client
  has_one :work
end
