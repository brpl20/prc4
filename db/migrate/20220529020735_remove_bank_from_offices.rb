class RemoveBankFromOffices < ActiveRecord::Migration[6.1]
  def change
    remove_column :offices, :bank, :string
    remove_column :offices, :agency, :string
    remove_column :offices, :account, :string
  end
end
