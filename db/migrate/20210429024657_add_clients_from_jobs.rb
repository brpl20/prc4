class AddClientsFromJobs < ActiveRecord::Migration[6.1]
  def change
	add_reference :jobs, :client, foreign_key: true
  end
end
