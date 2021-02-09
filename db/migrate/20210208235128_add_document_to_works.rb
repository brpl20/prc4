class AddDocumentToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :document, :json
  end
end
