class AddEscolhaToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :escolha, :boolean
  end
end
