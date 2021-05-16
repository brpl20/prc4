class AddEmailToOffices < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :email, :string
  end
end
