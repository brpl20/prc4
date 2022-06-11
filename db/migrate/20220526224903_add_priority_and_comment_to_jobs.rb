# frozen_string_literal: true

class AddPriorityAndCommentToJobs < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :work, null: true, foreign_key: true
    add_column :jobs, :priority, :integer
    add_column :jobs, :comment, :string
  end
end
