class Office < ApplicationRecord
  has_many :work_offices
  has_many :works, through: :work_offices
  belongs_to :user

  def full_account_details(id)
    details = Office.find(id)
    return "Banco: #{details.bank}, Agência: #{details.agency}, Conta: #{details.account}"
  end

  scope :sksz, -> { where(:bank => "Sicredi (748)") && where(:account => "7243-4")  }

  def full_name
    "#{name} #{lastname}"
  end

end
