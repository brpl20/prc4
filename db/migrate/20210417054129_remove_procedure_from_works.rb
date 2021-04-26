class RemoveProcedureFromWorks < ActiveRecord::Migration[6.1]
  def change
    remove_column :works, :procedure, :string
  end
end
