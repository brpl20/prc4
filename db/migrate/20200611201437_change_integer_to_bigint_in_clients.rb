class ChangeIntegerToBigintInClients < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :telefone, :bigint
    change_column :clients, :cep, :bigint
    change_column :clients, :telefone, :bigint
    change_column :clients, :cpf, :bigint
  end
end
