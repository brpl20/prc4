# frozen_string_literal: true

class CreateCustomerClients < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_clients do |t|
      t.references :client, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
