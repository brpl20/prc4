module ClientsHelper
  def gender_name(gender)
    gender == 0 ? 'Masculino' : 'Feminino'
  end

  def keys_to_status
    Client.statuses
  end

  def options_for_gender
    [['Masculino', 0], ['Feminino', 1]]
  end


  def options_for_citizenship
    [['Brasileiro', 'Brasileiro'], ['Estrangeiro', 'Estrangeiro']]
  end

  def options_for_civilstatus_client
    [['Solteiro', 'Solteiro'], ['Casado', 'Casado'], ['Divorciado', 'Divorciado'], ['Viúvo', 'Viúvo'], ['União Estável', 'em União Estável']]
  end

  def options_for_client_type
    [
      ['Pessoa Física', 0],
      ['Pessoa Jurídica', 1],
      ['Representante Legal', 2],
      ['Contador', 3]
    ]
  end

  def options_for_status_client
    [['Ativo', 0], ['Inativo', 1], ['Prospecção', 2], ['Abandonado/ Desistente', 3]]
  end

  def options_for_capacity
    [['Capaz', 'Capaz'], ['Relativamente Incapaz', 'Relativamente Incapaz'], ['Absolutamente Incapaz', 'Absolutamente Incapaz']]
  end

  def options_for_choice
    [['Consulta Simples', true], ['Adicionar Trabalho', false]]
  end

  def human_attribute_statuses
    Hash[Client.statuses.map { |k, v| [k, Client.human_attribute_name('status.#{k}')] }]
  end

  def jobs_to_this_client?(client)
    @jobs = Job.where(client_id: client.id)
  end

  def options_for_states
    [%w[Acre AC], [ 'Alagoas', 'AL' ], [ 'Amapá', 'AP' ], [ 'Amazonas', 'AM' ], [ 'Bahia', 'BA' ], [ 'Ceará', 'CE' ], [ 'Distrito Federal', 'DF' ], [ 'Espírito Santo', 'ES' ], [ 'Goiás', 'GO' ], [ 'Maranhão', 'MA' ], [ 'Mato Grosso', 'MT' ], [ 'Mato Grosso do Sul', 'MS' ], [ 'Minas Gerais','MG' ], [ 'Pará', 'PA' ], [ 'Paraíba', 'PB' ], [ 'Paraná', 'PR' ], [ 'Pernambuco', 'PE' ], [ 'Piauí', 'PI' ], [ 'Rio de Janeiro', 'RJ' ], [ 'Rio Grande do Norte', 'RN' ], [ 'Rio Grande do Sul', 'RS' ], [ 'Rondônia', 'RO' ], [ 'Roraima', 'RR' ], [ 'Santa Catarina', 'SC' ], [ 'São Paulo', 'SP' ], [ 'Sergipe', 'SE' ], [ 'Tocantins', 'TO' ], [ 'Estrangeiro', 'EX' ] ]
  end

  def retrieve_represented(id)
    id ? Client.find(id).name : 'não informado'
  end

  def retrieve_type_to_link(type)
    case type
    when 0
      'pf'
    when 1
      'pj'
    when 2
      'rep'
    when 3
      'cont'
    end
  end
end
