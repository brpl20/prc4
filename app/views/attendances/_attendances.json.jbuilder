json.extract! attendance, :id, :name, :lastname, :origin, :status, :responsible, :telephone, :email, :subject, :notes, :channel, :created_at, :updated_at
json.url attndance_url(attendance, format: :json)
