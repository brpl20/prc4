class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :address
      t.date :birth
      t.integer :capacity
      t.string :citizenship
      t.string :city
      t.string :civilstatus
      t.string :company
      t.string :email
      t.string :first_name
      t.string :lastname
      t.integer :gender
      t.string :general_register
      t.string :mothername
      t.string :number_benefit
      t.string :oab_number
      t.string :profession
      t.string :social_number
      t.string :state
      t.string :zip
      t.integer :status
      t.integer :life

      t.timestamps
    end
  end
end
