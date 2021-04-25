class CreateJoinTableChecklistDocumentWork < ActiveRecord::Migration[6.1]
  def change
    create_join_table :checklist_documents, :works do |t|
      t.index :checklist_document_id
      t.index :work_id
    end
  end
end
