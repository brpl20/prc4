json.extract! client, :id, :genero, :name, :lastname, :citizenship, :civilstatus, :capacity, :profession, :company, :birth, :mothername, :number_benefit, :general_register, :social_number, :email, :adress, :city, :state, :bank, :agency, :account, :zip, :telephone, :documents, :created_at, :updated_at
json.url client_url(client, format: :json)
