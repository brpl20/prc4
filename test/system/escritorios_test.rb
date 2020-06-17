require "application_system_test_case"

class EscritoriosTest < ApplicationSystemTestCase
  setup do
    @escritorio = escritorios(:one)
  end

  test "visiting the index" do
    visit escritorios_url
    assert_selector "h1", text: "Escritorios"
  end

  test "creating a Escritorio" do
    visit escritorios_url
    click_on "New Escritorio"

    fill_in "Agencia", with: @escritorio.agencia
    fill_in "Banco", with: @escritorio.banco
    fill_in "Cep", with: @escritorio.cep
    fill_in "Cidade", with: @escritorio.cidade
    fill_in "Cnpj", with: @escritorio.cnpj
    fill_in "Conta", with: @escritorio.conta
    fill_in "Endereco", with: @escritorio.endereco
    fill_in "Estado", with: @escritorio.estado
    fill_in "Fundacao", with: @escritorio.fundacao
    fill_in "Nome", with: @escritorio.nome
    fill_in "Oab", with: @escritorio.oab
    fill_in "Site", with: @escritorio.site
    fill_in "Telefone", with: @escritorio.telefone
    fill_in "Tipo", with: @escritorio.tipo
    click_on "Create Escritorio"

    assert_text "Escritorio was successfully created"
    click_on "Back"
  end

  test "updating a Escritorio" do
    visit escritorios_url
    click_on "Edit", match: :first

    fill_in "Agencia", with: @escritorio.agencia
    fill_in "Banco", with: @escritorio.banco
    fill_in "Cep", with: @escritorio.cep
    fill_in "Cidade", with: @escritorio.cidade
    fill_in "Cnpj", with: @escritorio.cnpj
    fill_in "Conta", with: @escritorio.conta
    fill_in "Endereco", with: @escritorio.endereco
    fill_in "Estado", with: @escritorio.estado
    fill_in "Fundacao", with: @escritorio.fundacao
    fill_in "Nome", with: @escritorio.nome
    fill_in "Oab", with: @escritorio.oab
    fill_in "Site", with: @escritorio.site
    fill_in "Telefone", with: @escritorio.telefone
    fill_in "Tipo", with: @escritorio.tipo
    click_on "Update Escritorio"

    assert_text "Escritorio was successfully updated"
    click_on "Back"
  end

  test "destroying a Escritorio" do
    visit escritorios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Escritorio was successfully destroyed"
  end
end
