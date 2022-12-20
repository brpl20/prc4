class Office < ApplicationRecord
  has_many :work_offices
  has_many :works, through: :work_offices
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  has_one  :bank, dependent: :destroy
  has_one  :office_type

  accepts_nested_attributes_for :bank, allow_destroy: true
  accepts_nested_attributes_for :office_type, allow_destroy: true

  validates :name, :oab, :cnpj_number, :society, :foundation,
            :zip, :address, :city, :state, :telephone, :email,
            :user_id, :office_type_id, presence: true

  def full_account_details(id)
    details = Office.find(id)
    "Banco: #{details.bank}, Agência: #{details.agency}, Conta: #{details.account}"
  end

end
