class ChangeStringToIntegerInAtendimentos < ActiveRecord::Migration[5.2]
  def change
    change_column :atendimentos, :status, :integer
  end
end
