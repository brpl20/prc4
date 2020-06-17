require "application_system_test_case"

class WorksTest < ApplicationSystemTestCase
  setup do
    @work = works(:one)
  end

  test "visiting the index" do
    visit works_url
    assert_selector "h1", text: "Works"
  end

  test "creating a Work" do
    visit works_url
    click_on "New Work"

    fill_in "Acao", with: @work.acao
    fill_in "Advogado parceiro", with: @work.advogado_parceiro
    fill_in "Advogado procuracao", with: @work.advogado_procuracao
    fill_in "Advogado responsavel", with: @work.advogado_responsavel
    fill_in "Atendimento inicial", with: @work.atendimento_inicial
    fill_in "Checklist", with: @work.checklist
    fill_in "Checklist documentos", with: @work.checklist_documentos
    fill_in "Documentos pendentes", with: @work.documentos_pendentes
    fill_in "Escritorio", with: @work.escritorio
    fill_in "Estagiarios procuracao", with: @work.estagiarios_procuracao
    fill_in "Honorarios parcelamento", with: @work.honorarios_parcelamento
    fill_in "Honorarios trab x exito", with: @work.honorarios_trab_x_exito
    fill_in "Honorariosf", with: @work.honorariosf
    fill_in "Honorariosf exfield", with: @work.honorariosf_exfield
    fill_in "Honorariosp", with: @work.honorariosp
    fill_in "Honorariosp exfield", with: @work.honorariosp_exfield
    fill_in "Indicacao", with: @work.indicacao
    fill_in "Indicacao comissao", with: @work.indicacao_comissao
    fill_in "Materia", with: @work.materia
    fill_in "Notas", with: @work.notas
    fill_in "Numero", with: @work.numero
    fill_in "Paralegais procuracao", with: @work.paralegais_procuracao
    fill_in "Pasta", with: @work.pasta
    fill_in "Poderes", with: @work.poderes
    fill_in "Tipo", with: @work.tipo
    click_on "Create Work"

    assert_text "Work was successfully created"
    click_on "Back"
  end

  test "updating a Work" do
    visit works_url
    click_on "Edit", match: :first

    fill_in "Acao", with: @work.acao
    fill_in "Advogado parceiro", with: @work.advogado_parceiro
    fill_in "Advogado procuracao", with: @work.advogado_procuracao
    fill_in "Advogado responsavel", with: @work.advogado_responsavel
    fill_in "Atendimento inicial", with: @work.atendimento_inicial
    fill_in "Checklist", with: @work.checklist
    fill_in "Checklist documentos", with: @work.checklist_documentos
    fill_in "Documentos pendentes", with: @work.documentos_pendentes
    fill_in "Escritorio", with: @work.escritorio
    fill_in "Estagiarios procuracao", with: @work.estagiarios_procuracao
    fill_in "Honorarios parcelamento", with: @work.honorarios_parcelamento
    fill_in "Honorarios trab x exito", with: @work.honorarios_trab_x_exito
    fill_in "Honorariosf", with: @work.honorariosf
    fill_in "Honorariosf exfield", with: @work.honorariosf_exfield
    fill_in "Honorariosp", with: @work.honorariosp
    fill_in "Honorariosp exfield", with: @work.honorariosp_exfield
    fill_in "Indicacao", with: @work.indicacao
    fill_in "Indicacao comissao", with: @work.indicacao_comissao
    fill_in "Materia", with: @work.materia
    fill_in "Notas", with: @work.notas
    fill_in "Numero", with: @work.numero
    fill_in "Paralegais procuracao", with: @work.paralegais_procuracao
    fill_in "Pasta", with: @work.pasta
    fill_in "Poderes", with: @work.poderes
    fill_in "Tipo", with: @work.tipo
    click_on "Update Work"

    assert_text "Work was successfully updated"
    click_on "Back"
  end

  test "destroying a Work" do
    visit works_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Work was successfully destroyed"
  end
end
