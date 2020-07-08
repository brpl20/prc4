class AddNameToFinanceiro < ActiveRecord::Migration[6.0]
  def change
    add_column :financeiros, :name, :string
  end
end
