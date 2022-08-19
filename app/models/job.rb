# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :client
  has_one :work

  validates :description, :deadline, :client, :responsable, :status, :priority, presence: true
end
