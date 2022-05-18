module ClientsHelper
  def gender_name(gender)
    gender == 0 ? 'Masculino' : 'Feminino'
  end

  def keys_to_status
    Client.statuses
  end

  def options_for_gender
    gender = [['Masculino', 0], ['Feminino', 1]]
  end


  def options_for_citizenship
    citizenship = [["Brasileiro", "Brasileiro"], ["Estrangeiro", "Estrangeiro"]]
  end

  def options_for_civilstatus_client
    civilstatus = [["Solteiro", "Solteiro"], ["Casado", "Casado"], ["Divorciado", "Divorciado"], ["Viúvo", "Viúvo"], ["União Estável", "em União Estável"]]
  end

  def options_for_client_type
    client_type = [["Pessoa Física", 0], ["Pessoa Jurídica", 1]]
  end

  def options_for_capacity
    capacity = [["Capaz", "Capaz"], ["Relativamente Incapaz", "Relativamente Incapaz"], ["Absolutamente Incapaz", "Absolutamente Incapaz"], ["Pessoa Jurídica", "Pessoa Jurídica"]]
  end

  def options_for_choice
    choice = [["Consulta Simples", true], ["Adicionar Trabalho", false]]
  end

  def human_attribute_statuses
    Hash[Client.statuses.map { |k,v| [k, Client.human_attribute_name("status.#{k}")] }]
  end

end
