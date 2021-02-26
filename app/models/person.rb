class Person < ApplicationRecord
  enum status: { active: 0, inactive: 1 }
  enum life:  { lawyer: 0, paralegal: 1, intern: 2, secretary: 3 }
  enum gender: { male: 0, female: 1 }
end
