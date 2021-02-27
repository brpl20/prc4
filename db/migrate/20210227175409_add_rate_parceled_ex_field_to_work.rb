class AddRateParceledExFieldToWork < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :rate_parceled_exfield, :string
  end
end
