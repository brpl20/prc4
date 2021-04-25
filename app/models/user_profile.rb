class UserProfile < ApplicationRecord
  belongs_to :user

  def full_name
    [self.name,self.lastname].join(' ')
  end
end
