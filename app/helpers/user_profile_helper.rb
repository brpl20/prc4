module UserProfileHelper

  def options_for_gender
    gender = [['Masculino', 1], ['Feminino', 2]]
  end

  def options_for_civilstatus
    civilstatus = [["Solteiro(a)", 1], ["Casado(a)", 2], ["Divorciado(a)", 3], ["Viúvo(a)", 4], ["União Estável", 4]]
  end

  def options_for_status
    status = [['Ativo', 1], ['Inativo', 2]]
  end

end
