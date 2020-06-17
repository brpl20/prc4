class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.integer :genero
      t.string :nome
      t.string :sobrenome
      t.string :nacionalidade
      t.string :estadocivil
      t.string :capacidade
      t.string :profissao
      t.string :empresa_atual
      t.date :nascimento
      t.string :mae
      t.integer :nb
      t.string :rg
      t.integer :cpf
      t.string :email
      t.string :endereco
      t.string :cidade
      t.string :estado
      t.integer :banco
      t.integer :agencia
      t.integer :conta
      t.integer :cep
      t.integer :telefone
      t.json :documentos

      t.timestamps
    end
  end
end
