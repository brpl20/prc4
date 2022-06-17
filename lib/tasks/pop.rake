namespace :pop do

  desc "Setup Development"
  task setup: :environment do

    p "Executando o setup para desenvolvimento..."

    p "Apagando banco de dados"
    p %x(rake db:drop)
    p "Banco de dados apagado com sucesso"

    p "Criando banco de dados"
    p %x(rake db:create)
    p "Banco de dados criado com sucesso"

    p "Migrando tabelas ..."
    p %x(rake db:migrate)
    p "Migração concluída com sucesso"

    p %x(rake pop:generate_procedures)

    p %x(rake cad:user)

    p %x(rake cad:client)

    p %x(rake cad:office_type)

    p %x(rake cad:office)

    p %x(rake pop:generate_powers)

    p %x(rake pop:generate_checklists)

    p %x(rake pop:generate_checklist_documents)

    p "Setup finalizado com sucesso!"
  end

desc "Cadastra Procedimentos"
  task generate_procedures: :environment do

    puts "Cadastrando Procedimentos"
    procedure = ["Administrativo", "Judicial", "Extrajudicial"]

    procedure.each do |c|
    Procedure.find_or_create_by!(
      description: "#{c}"
    )
    end
    puts "Procedimentos cadastrados com sucesso!!!"

  end

  task generate_powers: :environment do

    puts "Cadastrando Powers"
    powers =
     ["Ad Judicia", "Citação, Desistir do Pedido", "Firmar e Declarar Imposto de Renda e Isenções", "Confessar", "Reconhecer a procedência do pedido", "Desistir do processo e substabelecer com ou sem reserva de poderes", "Transigir", "Indicar e-mail do escritório para notificações e intimações", "Firmar compromissos e acordos", "Desistir do processo e incidentes", "Renunciar ao direito o qual se funda a ação", "Receber e dar quitação", "Carência - firmar compromissos e assinar declaração de hipossuficiência econômica", "Termo renúncia - firmar termo de renúncia para fins de Juizado Especial", "RPV - Renunciar valores superiores à Requisições de Pequeno Valor em Precatórios", "Sigilo médico - acessar documentos resguardados pelo sigilo médico independente do seu teor", "Representar adm - assinar, protocolar requerimentos, desistir de pedidos ou de benefícios, fazer carga de processos, ter vistas e acessar documentos bem como acesso digital, gerar, cadastrar e-mail, telefone e senhas nos portais Gov.br e Meu INSS", "Titulares Falecidos - buscar informações de titularidade de seus familiares falecidos para informação e instrução de seus pedidos pessoais", "Institutos Prisionais - buscar informações de titularidade de familiares em relação a dados cadastrais prisionais, para fins de concessão do benefício de auxílio reclusão", "Instituto Nacional do Seguro Social - INSS", "PRPrev - Paraná Previdência"]

    powers.each do |p|
    Power.create!(
      description: "#{p}"
    )
    end
    puts "Power cadastrados com sucesso!!!"

  end

  task generate_checklists: :environment do

    puts "Cadastrando checklist"
    checklists = ["Procuracão", "Termo de Renúncia", "Declaração de Carência", "Termo de Residência", "Declaração Rural"]

    checklists.each do |ck|
    Checklist.find_or_create_by!(
      description: "#{ck}"
    )
    end
    puts "Checklist cadastrados com sucesso!!!"

  end

  task generate_checklist_documents: :environment do

    puts "Cadastrando checklist_documents"
    checklist_documents = [ "Documento de Identidade",
                            "Comprovante de Residência",
                            "Senha do Meu INSS",
                            "Documentos Médicos",
                            "Documentos Rurais",
                            "Cópia de Requerimento(s)"]

    checklist_documents.each do |cd|
    ChecklistDocument.find_or_create_by!(
      description: "#{cd}"
    )
    end
    puts "Checklist_Documents cadastrados com sucesso!!!"

  end

end
