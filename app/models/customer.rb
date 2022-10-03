# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :customer_clients, dependent: :destroy
  has_many :clients, through: :customer_clients

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
