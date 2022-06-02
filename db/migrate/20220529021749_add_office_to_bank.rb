class AddOfficeToBank < ActiveRecord::Migration[6.1]
  def change
    add_reference :banks, :office, null: true, foreign_key: true
  end
end
