class RemovePerdNumberFromTributaries < ActiveRecord::Migration[6.1]
  def change
    remove_column :tributaries, :perd_number, :string
    remove_column :tributaries, :shipping_date, :date
    remove_column :tributaries, :payment_date, :date
    remove_column :tributaries, :status, :integer
  end
end
