class CreateTributaries < ActiveRecord::Migration[6.1]
  def change
    create_table :tributaries do |t|
      t.integer :compensation
      t.integer :craft
      t.integer :lawsuit
      t.decimal :projection
      t.string :perd_number
      t.date :shipping_date
      t.date :payment_date
      t.integer :status
      t.references :work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
