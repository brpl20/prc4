class AddOfficeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :office_id, :integer
  end
end
