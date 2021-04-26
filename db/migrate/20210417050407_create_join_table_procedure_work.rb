class CreateJoinTableProcedureWork < ActiveRecord::Migration[6.1]
  def change
    create_join_table :procedures, :works do |t|
      t.index :procedure_id
      t.index :work_id
    end
  end
end
