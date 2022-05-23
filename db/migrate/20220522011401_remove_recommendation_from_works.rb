class RemoveRecommendationFromWorks < ActiveRecord::Migration[6.1]
  def change
    remove_column :works, :recommendation, :string
    remove_column :works, :recommendation_comission, :string
  end
end
