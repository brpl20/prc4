class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :agency
      t.string :account
      t.references :client, null: true, foreign_key: true

      t.timestamps
    end
  end
end
