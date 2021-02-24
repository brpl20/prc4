class ClientWork < ActiveRecord::Migration[6.0]
  def change
    create_table :clients_works do |t|
      t.references :client, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end

# criada com rails g migration ClientWork client:references work:references
# Depois adicionado o create_table
