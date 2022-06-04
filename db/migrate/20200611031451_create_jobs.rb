class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.text :description
      t.date :deadline
      t.string :responsable
      t.string :status

      t.timestamps
    end
  end
end
