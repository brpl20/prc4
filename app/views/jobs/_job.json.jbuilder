json.extract! job, :id, :descricao, :prazo, :responsavel, :status, :created_at, :updated_at
json.url job_url(job, format: :json)
