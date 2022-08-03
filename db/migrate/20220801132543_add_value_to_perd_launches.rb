class AddValueToPerdLaunches < ActiveRecord::Migration[6.1]
  def change
    add_column :perd_launches, :value, :string
    add_column :perd_launches, :responsible, :string
    add_column :perd_launches, :perd_style, :string
  end
end
