class CreateAtendimentos < ActiveRecord::Migration[5.2]
  def change
    create_table :atendimentos do |t|
      t.string :nome
      t.string :sobrenome
      t.string :origem
      t.integer :status
      t.string :responsavel
      t.integer :telefone
      t.string :email
      t.string :assunto
      t.string :notas

      t.timestamps
    end
  end
end
