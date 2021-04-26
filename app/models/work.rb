class Work < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :powers
  has_and_belongs_to_many :procedures
  has_and_belongs_to_many :checklists
  has_and_belongs_to_many :checklist_documents

  has_many :client_works
  has_many :clients, through: :client_works

  has_many :work_offices
  has_many :offices, through: :work_offices

  accepts_nested_attributes_for :client_works, :work_offices, reject_if: :all_blank, allow_destroy: true


  # Retirar NIL
  NULL_ATTRS = %w( subject action number rate_percentage rate_percentage_exfield rate_fixed rate_fixed_exfield rate_work rate_parceled rate_parceled_exfield recommendation recommendation_comission folder initial_atendee procuration_lawyer procuration_intern procuration_paralegal partner_lawyer note document_pendent checklist checklist_document power )
  before_save :fill_if_nil

  protected

    def fill_if_nil
      NULL_ATTRS.each { |attr| self[attr] = "Campo Vazio" if self[attr].nil? }
    end

end
