class AddUserToBank < ActiveRecord::Migration[6.1]
  def change
    add_reference :banks, :user, null: true, foreign_key: true
  end
end
