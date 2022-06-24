class AddOfficeTypeToOffice < ActiveRecord::Migration[6.1]
  def change
    add_reference :offices, :office_type, null: false, foreign_key: true
  end
end
