class AddClientTypeToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :client_type, :integer
  end
end
