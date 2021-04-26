class CreateWorkOffices < ActiveRecord::Migration[6.1]
  def change
    create_table :work_offices do |t|
      t.references :work, null: false, foreign_key: true
      t.references :office, null: false, foreign_key: true

      t.timestamps
    end
  end
end
