class CreateBankaccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :bankaccounts do |t|
      t.integer :bank
      t.integer :account
      t.integer :agency
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
