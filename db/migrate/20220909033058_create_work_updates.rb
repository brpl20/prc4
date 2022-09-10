class CreateWorkUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :work_updates do |t|
      t.string :description
      t.string :show_to
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
