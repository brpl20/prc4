class CreateLawyers < ActiveRecord::Migration[5.2]
  def change
    create_table :lawyers do |t|
      t.integer :genero
      t.string :rg
      t.bigint :cpf
      t.string :oab
      t.string :nome
      t.string :sobrenome
      t.string :nacionalidade
      t.string :estadocivil
      t.date :nascimento
      t.string :mae
      t.string :email
      t.string :endereco
      t.string :cidade
      t.string :estado
      t.string :telefone
      t.string :email
      t.integer :banco
      t.bigint :telefone
      t.integer :agencia
      t.bigint :conta
      t.bigint :cep

      t.timestamps
    end
  end
end
