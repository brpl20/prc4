class ChangeInegerToBigintInClients < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :nb, :bigint
  end
end
