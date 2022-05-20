class UserProfile < ApplicationRecord
  belongs_to :user
  has_many :offices

  enum status: { active: 0, inactive: 1 }
  enum role:   { lawyer: 0, paralegal: 1, intern: 2, secretary: 3 }
  enum gender: { male: 0, female: 1 }

  def full_name
    [self.name,self.lastname].join(' ')
  end
end
