class CreateClientWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :client_works do |t|
      t.references :client, foreign_key: true
      t.references :work, foreign_key: true
      
      t.timestamps
    end
  end
end
