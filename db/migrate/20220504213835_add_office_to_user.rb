class AddOfficeToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :office, null: false, foreign_key: true, default: 1
  end
end
