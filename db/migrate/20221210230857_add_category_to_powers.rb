class AddCategoryToPowers < ActiveRecord::Migration[6.1]
  def change
    add_column :powers, :category, :integer
  end
end
