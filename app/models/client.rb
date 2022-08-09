# frozen_string_literal: true

class Client < ApplicationRecord

  has_one :bank, dependent: :destroy
  has_many :phones, inverse_of: :client, dependent: :destroy
  has_many :emails, inverse_of: :client, dependent: :destroy
  has_many :customer_types, inverse_of: :client, dependent: :destroy

  has_many :client_works, dependent: :destroy
  has_many :works, through: :client_works
  has_many :jobs
  has_many_attached :files

  accepts_nested_attributes_for :bank, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :customer_types, reject_if: :all_blank, allow_destroy: true

  validates :name, :lastname, :social_number, :gender, :civilstatus, :citizenship, :capacity, :birth, :phones, :emails, :address, :city, :state, :profession, presence: true, if: :zero

  def zero
    Proc.new { |c| c.client_type.zero? }
  end

  validates :phones, :emails, :address, :city, :state, presence: true, if: Proc.new { |c| c.client_type == 1 }

  validates :emails, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true

  validate :file_type

  DESCRIPTION = %w[Representante\ Legal Contador].freeze

  NULL_ATTRS = %w[lastname bank].freeze
  # before_save :fill_if_nil, :default_values

  def self.can_be_destroyed(id)
    ClientWork.exists?(client_id: id)
  end

  protected

  def file_type
    files.each do |file|
      unless file.content_type.in?(%{'image/jpeg image/png application/pdf'})
        errors.add(:files, 'apenas são permtidos nos formatos JPG, PNG ou PDF.')
      end
    end
  end

  def fill_if_nil
    NULL_ATTRS.each { |attr| self[attr] = '[Campo Vazio]' if self[attr].nil? }
  end

end
