class CreateFinance < ActiveRecord::Migration[6.0]
  def change
    create_table :finances do |t|
      t.references :client, null: false, foreign_key: true
      t.string :description
      t.timestamps
    end
  end
end
