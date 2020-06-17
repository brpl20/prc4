class AddCanalToAtendimentos < ActiveRecord::Migration[5.2]
  def change
    add_column :atendimentos, :canal, :string
  end
end
