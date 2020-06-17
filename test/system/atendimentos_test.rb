require "application_system_test_case"

class AtendimentosTest < ApplicationSystemTestCase
  setup do
    @atendimento = atendimentos(:one)
  end

  test "visiting the index" do
    visit atendimentos_url
    assert_selector "h1", text: "Atendimentos"
  end

  test "creating a Atendimento" do
    visit atendimentos_url
    click_on "New Atendimento"

    fill_in "Assunto", with: @atendimento.assunto
    fill_in "Email", with: @atendimento.email
    fill_in "Nome", with: @atendimento.nome
    fill_in "Notas", with: @atendimento.notas
    fill_in "Origem", with: @atendimento.origem
    fill_in "Responsavel", with: @atendimento.responsavel
    fill_in "Sobrenome", with: @atendimento.sobrenome
    fill_in "Status", with: @atendimento.status
    fill_in "Telefone", with: @atendimento.telefone
    click_on "Create Atendimento"

    assert_text "Atendimento was successfully created"
    click_on "Back"
  end

  test "updating a Atendimento" do
    visit atendimentos_url
    click_on "Edit", match: :first

    fill_in "Assunto", with: @atendimento.assunto
    fill_in "Email", with: @atendimento.email
    fill_in "Nome", with: @atendimento.nome
    fill_in "Notas", with: @atendimento.notas
    fill_in "Origem", with: @atendimento.origem
    fill_in "Responsavel", with: @atendimento.responsavel
    fill_in "Sobrenome", with: @atendimento.sobrenome
    fill_in "Status", with: @atendimento.status
    fill_in "Telefone", with: @atendimento.telefone
    click_on "Update Atendimento"

    assert_text "Atendimento was successfully updated"
    click_on "Back"
  end

  test "destroying a Atendimento" do
    visit atendimentos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Atendimento was successfully destroyed"
  end
end
