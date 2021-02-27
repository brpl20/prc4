class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.integer :gender
      t.string :name
      t.string :lastname
      t.string :citizenship
      t.string :civilstatus
      t.string :capacity
      t.string :profession
      t.string :company
      t.date :birth
      t.string :mothername
      t.string :number_benefit
      t.string :general_register
      t.string :social_number
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :bank
      t.string :agency
      t.string :account
      t.string :zip
      t.string :telephone
      t.json :documents

      t.timestamps
    end
  end
end
