module ClientsHelper

  def gender_select(user, current_gender)
    user.gender == current_gender ? 'btn-primary' : 'btn-default'
  end

  def options_for_gender
    gender = [['Masculino', 1], ['Feminino', 2]]
  end

  def options_for_citizenship
    citizenship = [["Brasileiro", "Brasileiro"], ["Estrangeiro", "Estrangeiro"]]
  end

  def options_for_civilstatus
    civilstatus = [["Solteiro", "Solteiro"], ["Casado", "Casado"], ["Divorciado", "Divorciado"], ["Viuvo", "Viuvo"], ["União Estável", "Em Uniao Estavel"]]
  end

  def options_for_capacity
    capacity = [["Capaz", "Capaz"], ["Relativamente Incapaz", "Relativamente Incapaz"], ["Absolutamente Incapaz", "Absolutamente Incapaz"]]
  end

  def options_for_choice
    choice = [["Consulta Simples", true], ["Adicionar Trabalho", false]]
  end
end
