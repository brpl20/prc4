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

    #p %x(rake cad:client)

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
    
    powers_general = ["Ad Judicia et extra"]

    powers_subs = ["substabelecer com ou sem reserva de poderes"]

    powers_special = [ 
     "citação", 
     "confessar",
     "reconhecer a procedência do pedido",
     "transigir", 
     "desistir do processo e incidentes",
     "renunciar ao direito o qual se funda a ação",
     "receber e dar quitação",
     "firmar compromissos",
     "firmar compromissos e assinar declaração de hipossuficiência econômica (Declaração de Carência)"
    ]

    powers_special_custom = [
      "indicar e-mail do escritório para notificações e intimações",
      "firmar termo de renúncia para fins de Juizado Especial",
      "renunciar valores superiores à Requisições de Pequeno Valor (RPV) em Precatórios"
    ]
    
    powers_adm_geral = [
      "Para representar, solicitar, assinar, dar ciência e retirar, cópias de processos administrativos"
    ]

    powers_prev = [
      "acessar documentos resguardados pelo sigilo médico independente do seu teor",
      "representar administrativamente - assinar, protocolar requerimentos, desistir de pedidos ou de benefícios, fazer carga de processos, ter vistas e acessar documentos bem como acesso digital, gerar, cadastrar e-mail, telefone e senhas nos portais Gov.br e Meu INSS", 
      "buscar informações de titularidade de seus familiares falecidos para informação e instrução de seus pedidos pessoais", 
      "buscar informações de titularidade de familiares em relação a dados cadastrais prisionais, para fins de concessão do benefício de auxílio reclusão", 
      "Instituto Nacional do Seguro Social - INSS", 
      "firmar e Declarar Imposto de Renda e Isenções",
      "PRPrev - Paraná Previdência",
      "renunciar valores superiores à Requisições de Pequeno Valor (RPV) em Precatórios"
    ]

    powers_tributario = [
      "Para representar, solicitar, assinar, dar ciência e retirar, cópias de processos administrativos",
      "cópia de processos administrativos de inscrição em dívida ativa",
      "negativas, protocolos, extratos de débitos, extrato de situação fiscal",
      "parcelamentos, extrato e saldo de parcelamentos, cópias de documentos", 
      "pedidos de ressarcimentos e restituições", 
      "pedido de ajuste de guia",
      "restrições de pessoa física, empresas e imóveis",
      "petições e requerimentos de qualquer natureza e demais documentos necessários para a liberação da competente certidão negativa de débitos (CND)",
      "certidão positiva com efeitos de negativa (CPD-EN)", 
      "alvará",
      "auto de infração",
      "notificação de lançamento", 
      "termo de confissão de dívida",
      "serviços previdenciários disponibilizados na internet e presencialmente pela SECRETARIA DA RECEITA FEDERAL DO BRASIL, PREVIDÊNCIA SOCIAL, PROCURADORIA GERAL DA FAZENDA NACIONAL",
      "extrato de contribuições de funcionários domésticos, REDARF’s", 
      "pedido de revisão de débito confessado em GFIP (DCG/LDCG)",
      "retificações de DARF, DCTFs e Speds", 
      "ajuste de GPS, DBE"
    ]

    powers_administrativo = ['poderes de direito administrativo']
    
    powers_civel =  ['poderes de direito administrativo']
    
    powers_civel_familia =  ['poderes de direito administrativo']

    powers_civel_cartorios_imoveis =  ['poderes de direito administrativo']

    powers_ecac = [
      "Acesso caixa postal",
      "Downloads speds (contábil/contribuições/icms ipi)",
      "Pagamentos e parcelamentos (consulta comprovantes) ",
      "Transmissão de declarações",
      "Declarações e demonstrativos (extrato dctf e cópia de declaração)",
      "Todas opções Restituição e Compensação (perdcomp)",
      "Certidões e consultas fiscais",
      "Dívida ativa da União",
      "PGFN - Consulta débitos inscritos a partir de 01/11/2012",
      "Sief Cobrança - intimações DCTF",
      "Acessar Per/Dcomp Web",
      "Comunicação para compensação de ofício"
    ] 
    # faltou beneficiário : CNPJ + e vigência 180 dias


    powers_trabalhista = [
      "Ingressar com Reclamatória Trabalhista"
      ]

    powers_criminal = 
    [ 
      "Acompanhamento em Inquérito Policial",
      "Defesa Criminal"
    ]
    
    def powers_create(powers, cat)
      powers.each do |p|
        Power.create!(
          description: "#{p}",
          category: cat
        )
        end
      puts "Poderes #{powers} (Power) cadastrados com sucesso!!!"
    end 

    powers_create(powers_general, 1)                         # ALL OPTIONS
    powers_create(powers_subs, 2)                            # ALL OPTIONS  
    powers_create(powers_special, 3)                         # ALL OPTIONS
    powers_create(powers_special_custom, 4)                  # ALL OPTIONS 
    powers_create(powers_adm_geral, 5)                       # PROCEDURE => ADMINISTRATIVO 
    powers_create(powers_prev, 6)                            # SUBJECT => PREVIDENCIARIO
    powers_create(powers_tributario, 7)                      # SUBJECT => TRIBUTARIO
    powers_create(powers_administrativo, 8)                  # SUBJECT => ADMINISTRATIVO 
    powers_create(powers_civel, 9)                           # SUBJECT => CIVEL 
    powers_create(powers_civel_familia, 10)                  # SUBJECT => CIVEL 
    powers_create(powers_civel_cartorios_imoveis, 11)        # SUBJECT => CIVEL 
    powers_create(powers_ecac, 12)                           # SUBJECT => TRIBUTARIO 
    powers_create(powers_trabalhista, 13)                    # SUBJECT => TRABALHISTA 
    powers_create(powers_criminal, 14)                       # SUBJECT => CRIMINAL 
  end

  # powers_general 
  # powers_subs 
  # powers_special 
  # powers_special_custom 
  # powers_adm_geral
  # powers_prev
  # powers_tributario
  # powers_administrativo 
  # powers_ecac
  # powers_trabalhista
  # powers_criminal

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
