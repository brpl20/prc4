class AddFieldsToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :status, :integer
    add_column :clients, :cnpj, :string
  end
end
