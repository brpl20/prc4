class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.text :descricao
      t.string :prazo
      t.string :responsavel
      t.string :status

      t.timestamps
    end
  end
end
