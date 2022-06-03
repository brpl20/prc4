class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :procedure
      t.string :subject
      t.string :action
      t.string :number
      t.string :rate_percentage
      t.string :rate_percentage_exfield
      t.string :rate_fixed
      t.string :rate_fixed_exfield
      t.string :rate_work
      t.string :rate_parceled
      t.text :power
      t.string :recommendation
      t.string :recommendation_comission
      t.string :folder
      t.string :initial_atendee
      t.string :procuration_lawyer
      t.string :procuration_intern
      t.string :procuration_paralegal
      t.string :partner_lawyer
      t.text :note
      t.string :checklist
      t.string :checklist_document
      t.string :document_pendent
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
