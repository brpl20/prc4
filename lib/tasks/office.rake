namespace :cad do

  desc "Cadastro de Usuários"
  task office: :environment do

    p "Criando office..."

    Office.find_or_create_by(
      name: "Pellizzetti Advocacia",
      oab: "4416",
      cnpj_number: "23.583.964/0001-05",
      society: "Unipessoal",
      foundation: "Thu, 24 Mar 2016",
      address: "Rua Paraná, 3033, Ed. Formato, 14 Andar",
      city: "Cascavel",
      state: "Paraná",
      zip: "85810-010",
      site: "www.pellizzetti.adv.br",
      telephone: "4530355898",
      email: "contato@pellizzetti.adv.br",
      user_id: 1
    )

    p 'Office criado com sucesso'
  end

end
