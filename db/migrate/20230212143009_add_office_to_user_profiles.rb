class AddOfficeToUserProfiles < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_profiles, :office, null: true, foreign_key: true
  end
end
