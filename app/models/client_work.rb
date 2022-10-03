# frozen_string_literal: true

class ClientWork < ApplicationRecord
  belongs_to :work
  belongs_to :client
end
