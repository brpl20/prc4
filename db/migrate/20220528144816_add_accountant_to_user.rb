class AddAccountantToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :accountant_role, :boolean
    add_column :users, :outside_accountant_role, :boolean
  end
end
