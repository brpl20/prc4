# frozen_string_literal: true

class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_one :bank, dependent: :destroy

  accepts_nested_attributes_for :user_profile, reject_if: :all_blank
  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name
    [user_profile.name, user_profile.lastname].join(' ')
  end
end
