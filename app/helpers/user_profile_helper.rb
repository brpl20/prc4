module UserProfileHelper

  def options_for_gender
    gender = [['Masculino', 1], ['Feminino', 2]]
  end

  def options_for_civilstatus
    civilstatus = [["Solteiro", "Solteiro"], ["Casado", "Casado"], ["Divorciado", "Divorciado"], ["Viúvo", "Viúvo"], ["União Estável", "em União Estável"]]
  end

  def options_for_status
    status = [['Ativo', 1], ['Inativo', 2]]
  end

end
