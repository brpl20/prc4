namespace :cad do

  desc "Cadastro de Usuários"
  task client: :environment do

    p "Criando cliente do sistema..."

    Client.create!(
       id: 48,
       gender: 1,
       name: "Allistair Lawson",
       lastname: "Reyes",
       citizenship: "Estrangeiro",
       civilstatus: "Casado",
       capacity: "Capaz",
       profession: "Veniam beatae volup",
       company: "Skinner and Raymond Inc",
       birth: 'Tue, 11 Nov 1975',
       mothername: "Erasmus Lopez",
       number_benefit: "645",
       general_register: "Labore impedit veni",
       social_number: "123.456.789-99",
       address: "Et sapiente ipsum d",
       city: "Explicabo Nihil eve",
       state: "Nisi magna quasi atq",
       bank: nil,
       agency: nil,
       account: nil,
       zip: "63.531",
       documents: nil,
       choice: true,
       status: 0,
       client_type: 0,
       nit: "123415689",
       passwdInss: "Verit@tis"
    )

    p 'Cliente criado com sucesso'
  end

end
