class CreateRecommendationWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendation_works do |t|
      t.references :client, null: false, foreign_key: true
      t.references :work, null: false, foreign_key: true
      t.decimal :percentage
      t.decimal :commission

      t.timestamps
    end
  end
end
