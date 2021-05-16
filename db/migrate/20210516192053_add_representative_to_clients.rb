class AddRepresentativeToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :representative, :text
  end
end
