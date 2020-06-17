require "application_system_test_case"

class LawyersTest < ApplicationSystemTestCase
  setup do
    @lawyer = lawyers(:one)
  end

  test "visiting the index" do
    visit lawyers_url
    assert_selector "h1", text: "Lawyers"
  end

  test "creating a Lawyer" do
    visit lawyers_url
    click_on "New Lawyer"

    fill_in "Agencia", with: @lawyer.agencia
    fill_in "Banco", with: @lawyer.banco
    fill_in "Cep", with: @lawyer.cep
    fill_in "Cidade", with: @lawyer.cidade
    fill_in "Conta", with: @lawyer.conta
    fill_in "Cpf", with: @lawyer.cpf
    fill_in "Email", with: @lawyer.email
    fill_in "Endereco", with: @lawyer.endereco
    fill_in "Estado", with: @lawyer.estado
    fill_in "Estadocivil", with: @lawyer.estadocivil
    fill_in "Genero", with: @lawyer.genero
    fill_in "Mae", with: @lawyer.mae
    fill_in "Nacionalidade", with: @lawyer.nacionalidade
    fill_in "Nascimento", with: @lawyer.nascimento
    fill_in "Nome", with: @lawyer.nome
    fill_in "Oab", with: @lawyer.oab
    fill_in "Rg", with: @lawyer.rg
    fill_in "Sobrenome", with: @lawyer.sobrenome
    fill_in "Telefone", with: @lawyer.telefone
    click_on "Create Lawyer"

    assert_text "Lawyer was successfully created"
    click_on "Back"
  end

  test "updating a Lawyer" do
    visit lawyers_url
    click_on "Edit", match: :first

    fill_in "Agencia", with: @lawyer.agencia
    fill_in "Banco", with: @lawyer.banco
    fill_in "Cep", with: @lawyer.cep
    fill_in "Cidade", with: @lawyer.cidade
    fill_in "Conta", with: @lawyer.conta
    fill_in "Cpf", with: @lawyer.cpf
    fill_in "Email", with: @lawyer.email
    fill_in "Endereco", with: @lawyer.endereco
    fill_in "Estado", with: @lawyer.estado
    fill_in "Estadocivil", with: @lawyer.estadocivil
    fill_in "Genero", with: @lawyer.genero
    fill_in "Mae", with: @lawyer.mae
    fill_in "Nacionalidade", with: @lawyer.nacionalidade
    fill_in "Nascimento", with: @lawyer.nascimento
    fill_in "Nome", with: @lawyer.nome
    fill_in "Oab", with: @lawyer.oab
    fill_in "Rg", with: @lawyer.rg
    fill_in "Sobrenome", with: @lawyer.sobrenome
    fill_in "Telefone", with: @lawyer.telefone
    click_on "Update Lawyer"

    assert_text "Lawyer was successfully updated"
    click_on "Back"
  end

  test "destroying a Lawyer" do
    visit lawyers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lawyer was successfully destroyed"
  end
end
