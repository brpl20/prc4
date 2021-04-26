class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :user_profile, dependent: :destroy

  accepts_nested_attributes_for :user_profile, reject_if: :all_blank

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


end
