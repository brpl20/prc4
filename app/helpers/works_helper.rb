module WorksHelper
  def options_for_client
    Client.order(:name).map{|c| [c.id, "#{c.name} #{c.lastname}"] }
  end

  def options_for_subject
    work = ["Previdenciário", "Previdenciário"],
            ["Cível", "Cível"],
            ["Trabalhista", "Trabalhista"],
            ["Tributáiro", "Tributário"],
            ["Outros", "Outros"]
  end

  def options_for_action_previdence
    previdence = [
      ["Aposentadoria Por Tempo de Contribuição", "Aposentadoria Por Tempo de Contribuição"],
      ["Aposentadoria Por Idade", "Aposentadoria Por Idade"],
      ["Aposentadoria Rural", "Aposentadoria Rural"],
      ["Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS", "Benefícios Por Incapacidade - Auxílio Doença ou Acidente - Invalidez - LOAS"],
      ["Revisão de Benefício Previdenciário", "Revisão de Benefício Previdenciário"],
      ["Pensão Por Morte", "Pensão Por Morte"],
      ["Auxílio Reclusão", "Auxílio Reclusão"],
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
    Power.all
  end

  def options_for_checklist
    Checklist.all
  end

  def options_for_checklist_document
    ChecklistDocument.all
  end

  def options_for_procedure
    Procedure.all
  end

  def initial_atendence id
    id ? UserProfile.find(id).name : 'não informado'
  end

  def has_jobs_to_this_work work
    @jobs = work.clients.last.jobs
  end

  def has_recommendation id
    Client.find(id).name
  end

end
