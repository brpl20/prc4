json.extract! attendance, :id, :name, :lastname, :origin, :status, :responsible, :telephone, :email, :subject, :note, :channel, :created_at, :updated_at
json.url attndance_url(attendance, format: :json)
