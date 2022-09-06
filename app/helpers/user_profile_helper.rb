module UserProfileHelper

  def options_for_gender
    [['Masculino', 0], ['Feminino', 1]]
  end

  def options_for_civilstatus
    [["Solteiro", "Solteiro"], ["Casado", "Casado"], ["Divorciado", "Divorciado"], ["Viúvo", "Viúvo"], ["União Estável", "em União Estável"]]
  end

  def options_for_status
    [['Ativo', 0], ['Inativo', 1]]
  end

  def options_for_user_role
    [
      ['Advogado', 0],
      ['Paralegal', 1],
      ['Estagiário', 2],
      ['Secretária', 3],
      ['Contador', 4],
      ['Contador Externo', 5]
    ]
  end
end
