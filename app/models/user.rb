class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :user_profile, dependent: :destroy
  has_one  :bank, dependent: :destroy

  accepts_nested_attributes_for :user_profile, reject_if: :all_blank
  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name
    [self.user_profile.name,self.user_profile.lastname].join(' ')
  end

end
