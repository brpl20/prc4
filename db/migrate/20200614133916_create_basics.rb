class CreateBasics < ActiveRecord::Migration[5.2]
  def change
    create_table :basics do |t|
      t.string :checklist
      t.string :poderes

      t.timestamps
    end
  end
end
