class RemoveRecommendationValuePercentageFromClientWorks < ActiveRecord::Migration[6.1]
  def change
    remove_column :client_works, :recommendation, :integer
    remove_column :client_works, :value, :decimal
    remove_column :client_works, :percentage, :decimal
  end
end
