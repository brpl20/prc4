namespace :pop do

  desc "Setup Development"
  task setup: :environment do

    puts "Executando o setup para desenvolvimento..."

    puts %x(rake db:seed)
    puts %x(rake pop:generate_procedures)
    puts %x(rake pop:generate_powers)
    puts %x(rake pop:generate_checklists)
    puts %x(rake pop:generate_checklist_documents)

    puts "Setup finalizado com sucesso!"
  end
  #################################################################

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
    powers = ["Ad Judicia", "Citacao", "Desistir do pedido", "Firmar e Declarar Imposto de Renda e Isenções", "Fazer Pedidos, Requisições, Desistência, Senha Junto ao INSS, inclusive protegidos pelo sigilo médico", "Mais"]

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
