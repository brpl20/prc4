class AddRecommendationToClientWork < ActiveRecord::Migration[6.1]
  def change
    add_column :client_works, :recommendation, :integer
    add_column :client_works, :value, :decimal
    add_column :client_works, :percentage, :decimal
  end
end
