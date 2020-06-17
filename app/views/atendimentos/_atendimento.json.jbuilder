json.extract! atendimento, :id, :nome, :sobrenome, :origem, :status, :responsavel, :telefone, :email, :assunto, :notas, :created_at, :updated_at
json.url atendimento_url(atendimento, format: :json)
