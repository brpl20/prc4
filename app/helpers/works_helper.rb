module WorksHelper
  def options_for_client
    Client.order(:name).map{|c| [c.id, "#{c.name} #{c.lastname}"] }
  end

  def options_for_subject
    work = ["Previdenciário", "Previdenciário"],
            ["Cível", "Cível"],
            ["Trabalhista", "Trabalhista"],
            ["Tributário", "Tributário"],
            ["Tributário Pis/Cofins insumos", "Tributário Pis/Cofins insumos"],
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
                  ["Alvará", "Alvará"],
                  ["Ressarcimento PIS/COFINS Insumos", "Ressarcimento PIS/COFINS Insumos"],
                  ["Inss - Verbas Indenizatórias", "Inss - Verbas Indenizatórias"],
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

  def initial_atendence(id)
    id ? UserProfile.find(id).name : 'não informado'
  end

  def jobs_to_this_work?(work)
    @jobs = Job.where(work_id: work.id)
  end

  def perd_comp_to_this_work?(tributary)
    if tributary != nil
      @perdlaunches = PerdLaunch.where(tributary_id: tributary.id)
    end
  end

  def has_recommendation(id)
    Client.find(id).name
  end

  def options_for_radio_yes(op)
    if op == 1
      'Não'
    else
      if op == 0
        'Sim'
      end
    end
  end

  def options_for_radio_status(op)
    if op == 1
      'Paga'
    else
      if op == 0
        'Pendende de Análise'
      end
    end
  end

end
