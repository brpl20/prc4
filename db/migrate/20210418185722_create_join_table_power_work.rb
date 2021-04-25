class CreateJoinTablePowerWork < ActiveRecord::Migration[6.1]
  def change
    create_join_table :powers, :works do |t|
      t.index :power_id
      t.index :work_id
    end
  end
end
