module WorksHelper
  def options_for_subject
    work = [["Previdenciário", "Previdenciário"],
            ["Cível", "Cível"],
            ["Trabalhista", "Trabalhista"],
            ["Tributáiro", "Tributário"],
            ["Outros", "Outros"]]
  end

  def options_for_action_previdence
    previdence = [
      ["Aposentadoria Por Tempo de Contribuição", "Aposentadoria Por Tempo de Contribuição"],
      ["Aposentadoria Por Idade", "Aposentadoria Por Idade"],
      ["Aposentadoria Rural", "Aposentadoria Rural"],
      ["Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS", "Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS"],
      ["Revisão de Benefício Previdenciário", "Revisão de Benefício Previdenciário"],
      ["Reconhecimento de Tempo, Averbação, Serviços Administrativos", "Reconhecimento de Tempo, Averbação, Serviços Administrativos"]]
  end

  def options_for_action_civil
    civil = [
        ["Família", "Família"],
        ["Consumidor", "Consumidor"],
        ["Reparação Cível - Danos Materiais - Danos Morais", "Reparação Cível - Danos Materiais, Danos Morais"],
        ]
  end

  def options_for_action_labor
    labor = [["Reclamatória Trabalhista", "Reclamatória Trabalhista"]]
  end

  def options_for_action_tributary
    tributary = [ ["Asfalto", "Asfalto"],
                  ["Alfavá", "Alvará"],
                  ["Outros", "Outros"]
                ]
  end

  def options_for_rate_work
    rate_work = [["Trabalho", "Trabalho"], ["Êxito", "Êxito"], ["Ambos", "Ambos"]]
  end

  def options_for_rate_parceled
    rate_parceled = [["Sim", "Sim"], ["Não", "Não"]]
  end

  def options_for_check_boxes
    check_boxes = [
                ["Ad Judicia", "Ad Judicia"],
                ["Citacao", "Citacao"],
                ["Desistir do pedido", "Desistir do Pedido"],
                ["Firmar e Declarar Imposto de Renda e Isenções", "Firmar e Declarar Imposto de Renda e Isenções"],
                ["Fazer Pedidos, Requisições, Desistência, Senha Junto ao INSS, inclusive protegidos pelo sigilo médico", "Fazer Pedidos, Requisições, Desistência, Senha Junto ao INSS, inclusive protegidos pelo sigilo médico"],
                ["Mais...", "Mais..."]
              ]
  end

  def options_for_checklist
    checklist = [
                  ["Procuracão", "Procuracão"],
                  ["Termo de Renúncia", "Termo de Renúncia"],
                  ["Declaração de Carência", "Declaração de Carência"],
                  ["Termo de Residência", "Termo de Residência"],
                  ["Declaração Rural", "Declaração Rural"]
                ]
  end

  def options_for_checklist_document
    checklist_document = [
              ["Documento de Identidade", "Documento de Identidade"],
              ["Comprovante de Residência", "Comprovante de Residência"],
              ["Senha do Meu INSS", "Senha do Meu INSS"],
              ["Documentos Médicos", "Documentos Médicos"],
              ["Documentos Rurais", "Documentos Rurais"],
              ["Cópia de Requerimento(s)", "Cópia de Requerimento(s)"]
            ]
  end
  def options_for_procedure
    procedure = [ ["Administrativo", "Administrativo"],
                  ["Judicial", "Judicial"],
                  ["Extrajudicial", "Extrajudicial"]
                ]
  end
end
