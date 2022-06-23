class CreatePerdLaunches < ActiveRecord::Migration[6.1]
  def change
    create_table :perd_launches do |t|
      t.string :perd_number
      t.date :shipping_date
      t.date :payment_date
      t.integer :status
      t.references :tributary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
