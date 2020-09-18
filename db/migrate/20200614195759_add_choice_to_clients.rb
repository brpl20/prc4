class AddChoiceToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :choice, :boolean
  end
end
