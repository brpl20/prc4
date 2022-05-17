class CostumerType < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_types do |t|
      t.integer :represented
      t.string :description
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
