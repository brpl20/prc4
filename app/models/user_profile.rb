class UserProfile < ApplicationRecord
  belongs_to :user

  def full_name
    [name, lastname].join(' ')
  end
end
