class AddPasswdInssToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :passwdInss, :string
  end
end
