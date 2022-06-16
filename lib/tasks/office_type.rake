namespace :cad do

  desc "Cadastro de Tipos de Escritório"
  task office_type: :environment do

    p "Criando tipos de Escritório..."

    OfficeType.find_or_create_by(
      description: "Advocacia"
    )

    OfficeType.find_or_create_by(
      description: "Contabilidade"
    )

    p 'Tipos de Escritório criado com sucesso'
  end

end
