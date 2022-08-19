class Office < ApplicationRecord
  has_many :work_offices
  has_many :works, through: :work_offices
  belongs_to :user
  has_one  :bank, dependent: :destroy
  has_one  :office_type, dependent: :destroy

  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :office_type, reject_if: :all_blank, allow_destroy: true

  validates :name, :oab, :cnpj_number, :society, :foundation,
            :zip, :address, :city, :state, :telephone, :email,
            :user_id, :office_type_id, presence: true

  def full_account_details(id)
    details = Office.find(id)
    "Banco: #{details.bank}, Agência: #{details.agency}, Conta: #{details.account}"
  end

  scope :sksz, -> { where(bank: 'Sicredi (748)') && where(account: '7243-4') }

  def full_name
    "#{name} #{lastname}"
  end
end
