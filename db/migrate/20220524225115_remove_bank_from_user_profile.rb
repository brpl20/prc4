class RemoveBankFromUserProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_profiles, :bank, :string
    remove_column :user_profiles, :agency, :string
    remove_column :user_profiles, :account, :string
  end
end
