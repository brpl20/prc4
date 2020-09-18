class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :type
      t.string :subject
      t.string :action
      t.string :number
      t.integer :rate_percentage
      t.boolean :rate_percentage_exfield
      t.decimal :rate_fixed
      t.boolean :rate_fixed_exfield
      t.decimal :rate_work
      t.string :rate_parceled
      t.text :powers
      t.string :recommendation
      t.string :recommendation_comission
      t.string :folder
      t.string :initial_atendee
      t.string :responsible_lawyer
      t.string :procuration_lawyer
      t.string :procuration_intern
      t.string :procuration_paralegal
      t.string :partner_lawyer
      t.text :notes
      t.string :checklist
      t.string :checklist_documents
      t.string :document_pendent

      t.timestamps
    end
  end
end
