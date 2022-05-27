# frozen_string_literal: true

class ChangeColumnTypeFromJobs < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :deadline, 'date USING CAST(deadline AS date)'
  end
end
