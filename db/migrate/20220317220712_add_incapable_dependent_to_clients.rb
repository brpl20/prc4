class AddIncapableDependentToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :incapable_dependent, :integer
  end
end
