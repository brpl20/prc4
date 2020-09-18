class CreateLawyers < ActiveRecord::Migration[6.0]
  def change
    create_table :lawyers do |t|
      t.integer :gender
      t.string :general_register
      t.bigint :social_number
      t.string :oab_number
      t.string :name
      t.string :lastname
      t.string :citizenship
      t.string :civilstatus
      t.date :birth
      t.string :mothername
      t.string :email
      t.string :adress
      t.string :city
      t.string :state
      t.string :telephone
      t.string :bank
      t.string :agency
      t.string :account
      t.string :zip

      t.timestamps
    end
  end
end
