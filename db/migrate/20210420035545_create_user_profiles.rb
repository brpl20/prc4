class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.integer :role
      t.string :name
      t.string :lastname
      t.integer :gender
      t.string :general_register
      t.string :oab
      t.string :social_number
      t.string :citizenship
      t.integer :civilstatus
      t.date :birth
      t.string :mothername
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :phone
      t.string :bank
      t.string :agency
      t.string :account
      t.string :zip
      t.integer :status
      t.string :origin
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
