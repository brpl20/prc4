class CreateJoinTableChecklistWork < ActiveRecord::Migration[6.1]
  def change
    create_join_table :checklists, :works do |t|
      t.index :checklist_id
      t.index :work_id
    end
  end
end
