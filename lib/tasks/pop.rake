namespace :pop do

  desc "Setup Development"
  task setup: :environment do

    puts "Executando o setup para desenvolvimento..."

    puts %x(rake db:drop db:create db:migrate db:seed)
    puts %x(rake pop:generate_procedures)
    puts %x(rake pop:generate_powers)
    puts %x(rake pop:generate_checklists)
    puts %x(rake pop:generate_checklist_documents)

    puts "Setup finalizado com sucesso!"
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
     ["Ad Judicia", 0, "helper",        "Ad Judicia"],
     ["Citação", 0, "helper,",          "Citação"],
     ["Desistir",  0, "helper,",        "Desistir do Pedido"],
     ["Imposto de Renda", 0, "helper",  "Firmar e Declarar Imposto de Renda e Isenções"],
     ["Confessar", 0, "helper",         "confessar"],
     ["Reconhecer o pedido", 0, "helper", "reconhecer a procedência do pedido"],
     ["Desistir", 0, "helper",          "desistir do processo e substabelecer com ou sem reserva de poderes"],
     ["Transigir", 0, "helper",          "transigir"],
     ["Indicar e-mail", 0, "helper",     "indicar e-mail do escritório para notificações e intimações"],
     ["Acordos", 0, "helper",            "firmar compromissos e acordos"],
     ["Desistir", 0, "helper",            "desistir do processo e incidentes"],
     ["Renunciar", 0, "helper",           "renunciar ao direito o qual se funda a ação"],
     ["Receber e dar quitação", 0, "helper", "receber e dar quitação"],
     ["Carência", 0, "helper", "firmar compromissos e assinar declaração de hipossuficiência econômica"],
     ["Termo renúncia", 0, "helper", "firmar termo de renúncia para fins de Juizado Especial"],
     ["RPV", 0, "helper", "renunciar valores superiores à Requisições de Pequeno Valor em Precatórios"],
     ["Sigilo médico", 0, "helper", "acessar documentos resguardados pelo sigilo médico, independente do seu teor"],
     ["Representar adm", 0, "helper", "representar, assinar, protocolar requerimentos, desistir de pedidos ou de benefícios, fazer carga de processos, ter vistas e acessar documentos, bem como acesso digital, gerar, cadastrar e-mail, telefone e segnhas nos portais Gov.br e Meu INSS"],
     ["Titulares Falecidos", 5, "buscar informações de titularidade de seus familiares falecidos para informação e instrução de seus pedidos pessoais"],
     ["Institutos Prisionais", 6, "buscar informações de titularidade de familiares em relação a dados cadastrais prisionais, para fins de concessão do benefício de auxílio reclusão"],
     ["INSS", 0, "helper", "Instituto Nacional do Seguro Social - INSS"],
     ["PRPrev", 0, "helper", "Paraná Previdência"]

    powers.each do |p|
    Power.find_or_create_by!(
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
