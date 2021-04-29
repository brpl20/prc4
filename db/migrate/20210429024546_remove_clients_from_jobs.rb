class RemoveClientsFromJobs < ActiveRecord::Migration[6.1]
  def change
    remove_reference :jobs, :clients, null: false, foreign_key: true
  end
end
