class AddRolesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lawyer_role, :boolean
    add_column :users, :paralegal_role, :boolean
    add_column :users, :intern_role, :boolean
    add_column :users, :secretary_role, :boolean
  end
end
