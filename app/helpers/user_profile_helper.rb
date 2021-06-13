module UserProfileHelper

  def options_for_gender
    gender = [['Masculino', 0], ['Feminino', 1]]
  end

  def options_for_civilstatus
    civilstatus = [["Solteiro", "Solteiro"], ["Casado", "Casado"], ["Divorciado", "Divorciado"], ["Viúvo", "Viúvo"], ["União Estável", "em União Estável"]]
  end

  def options_for_status
    status = [['Ativo', 0], ['Inativo', 1]]
  end

end
