module ClientsHelper
  def gender_name(gender)
    gender == 1 ? 'Masculino' : 'Feminino'
  end

  def options_for_gender
    gender = [['Masculino', 1], ['Feminino', 2]]
  end

  def options_for_citizenship
    citizenship = [["Brasileiro", "Brasileiro"], ["Estrangeiro", "Estrangeiro"]]
  end

  def options_for_civilstatus
    civilstatus = [["Solteiro", "Solteiro"], ["Casado", "Casado"], ["Divorciado", "Divorciado"], ["Viúvo", "Viúvo"], ["União Estável", "União Estável"]]
  end

  def options_for_capacity
    capacity = [["Capaz", "Capaz"], ["Relativamente Incapaz", "Relativamente Incapaz"], ["Absolutamente Incapaz", "Absolutamente Incapaz"]]
  end

  def options_for_choice
    choice = [["Consulta Simples", true], ["Adicionar Trabalho", false]]
  end
end
