# frozen_string_literal: true

class Client < ApplicationRecord
  has_one  :bank, dependent: :destroy
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

  validate :file_type

  DESCRIPTION = %w[Representante\ Legal Contador].freeze

  NULL_ATTRS = %w[lastname bank].freeze
  #before_save :fill_if_nil, :default_values

  protected

  #def default_values
  #  self.status = 0
  #end

  def file_type
    files.each do |file|
      unless file.content_type.in?(%('image/jpeg image/png application/pdf'))
        errors.add(:files, 'Adicione um arquivo JPG, PNG ou PDF.')
      end
    end
  end

  def fill_if_nil
    NULL_ATTRS.each { |attr| self[attr] = '[Campo Vazio]' if self[attr].nil? }
  end
end
