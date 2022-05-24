class AddNitToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :nit, :string
  end
end
