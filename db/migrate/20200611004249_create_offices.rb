class CreateOffices < ActiveRecord::Migration[6.0]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :oab
      t.string :cnpj_number
      t.integer :type
      t.date :foundation
      t.string :adress
      t.string :city
      t.string :state
      t.string :zip
      t.string :site
      t.string :telephone
      t.string :bank
      t.string :agency
      t.string :account

      t.timestamps
    end
  end
end
