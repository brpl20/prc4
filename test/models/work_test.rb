# == Schema Information
#
# Table name: works
#
#  id                      :bigint           not null, primary key
#  tipo                    :string
#  materia                 :string
#  acao                    :string
#  numero                  :integer
#  honorariosp             :string
#  honorariosp_exfield     :string
#  honorariosf             :string
#  honorariosf_exfield     :string
#  honorarios_trab_x_exito :string
#  honorarios_parcelamento :string
#  escritorio              :string
#  poderes                 :text
#  indicacao               :string
#  indicacao_comissao      :string
#  pasta                   :string
#  atendimento_inicial     :string
#  advogado_responsavel    :string
#  advogado_procuracao     :string
#  estagiarios_procuracao  :string
#  paralegais_procuracao   :string
#  advogado_parceiro       :string
#  notas                   :text
#  checklist               :string
#  checklist_documentos    :string
#  documentos_pendentes    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
