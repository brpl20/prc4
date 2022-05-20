class AddResponsibleToOffice < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :responsible, :integer
  end
end
