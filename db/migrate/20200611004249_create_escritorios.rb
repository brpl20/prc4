class CreateEscritorios < ActiveRecord::Migration[5.2]
  def change
    create_table :escritorios do |t|
      t.string :nome
      t.string :oab
      t.integer :cnpj
      t.integer :tipo
      t.date :fundacao
      t.string :endereco
      t.string :cidade
      t.string :estado
      t.integer :cep
      t.string :site
      t.integer :telefone
      t.integer :banco
      t.integer :agencia
      t.integer :conta

      t.timestamps
    end
  end
end
