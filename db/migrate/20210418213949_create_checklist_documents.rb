class CreateChecklistDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :checklist_documents do |t|
      t.string :description

      t.timestamps
    end
  end
end
