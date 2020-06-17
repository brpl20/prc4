json.extract! client, :id, :genero, :nome, :sobrenome, :nacionalidade, :estadocivil, :capacidade, :profissao, :empresa_atual, :nascimento, :mae, :nb, :rg, :cpf, :email, :endereco, :cidade, :estado, :banco, :agencia, :conta, :cep, :telefone, :documentos, :created_at, :updated_at
json.url client_url(client, format: :json)
