require 'test_helper'

class WorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work = works(:one)
  end

  test "should get index" do
    get works_url
    assert_response :success
  end

  test "should get new" do
    get new_work_url
    assert_response :success
  end

  test "should create work" do
    assert_difference('Work.count') do
      post works_url, params: { work: { acao: @work.acao, advogado_parceiro: @work.advogado_parceiro, advogado_procuracao: @work.advogado_procuracao, advogado_responsavel: @work.advogado_responsavel, atendimento_inicial: @work.atendimento_inicial, checklist: @work.checklist, checklist_documentos: @work.checklist_documentos, documentos_pendentes: @work.documentos_pendentes, escritorio: @work.escritorio, estagiarios_procuracao: @work.estagiarios_procuracao, honorarios_parcelamento: @work.honorarios_parcelamento, honorarios_trab_x_exito: @work.honorarios_trab_x_exito, honorariosf: @work.honorariosf, honorariosf_exfield: @work.honorariosf_exfield, honorariosp: @work.honorariosp, honorariosp_exfield: @work.honorariosp_exfield, indicacao: @work.indicacao, indicacao_comissao: @work.indicacao_comissao, materia: @work.materia, notas: @work.notas, numero: @work.numero, paralegais_procuracao: @work.paralegais_procuracao, pasta: @work.pasta, poderes: @work.poderes, tipo: @work.tipo } }
    end

    assert_redirected_to work_url(Work.last)
  end

  test "should show work" do
    get work_url(@work)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_url(@work)
    assert_response :success
  end

  test "should update work" do
    patch work_url(@work), params: { work: { acao: @work.acao, advogado_parceiro: @work.advogado_parceiro, advogado_procuracao: @work.advogado_procuracao, advogado_responsavel: @work.advogado_responsavel, atendimento_inicial: @work.atendimento_inicial, checklist: @work.checklist, checklist_documentos: @work.checklist_documentos, documentos_pendentes: @work.documentos_pendentes, escritorio: @work.escritorio, estagiarios_procuracao: @work.estagiarios_procuracao, honorarios_parcelamento: @work.honorarios_parcelamento, honorarios_trab_x_exito: @work.honorarios_trab_x_exito, honorariosf: @work.honorariosf, honorariosf_exfield: @work.honorariosf_exfield, honorariosp: @work.honorariosp, honorariosp_exfield: @work.honorariosp_exfield, indicacao: @work.indicacao, indicacao_comissao: @work.indicacao_comissao, materia: @work.materia, notas: @work.notas, numero: @work.numero, paralegais_procuracao: @work.paralegais_procuracao, pasta: @work.pasta, poderes: @work.poderes, tipo: @work.tipo } }
    assert_redirected_to work_url(@work)
  end

  test "should destroy work" do
    assert_difference('Work.count', -1) do
      delete work_url(@work)
    end

    assert_redirected_to works_url
  end
end
