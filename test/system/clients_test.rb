require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "creating a Client" do
    visit clients_url
    click_on "New Client"

    fill_in "Agencia", with: @client.agencia
    fill_in "Banco", with: @client.banco
    fill_in "Capacidade", with: @client.capacidade
    fill_in "Cep", with: @client.cep
    fill_in "Cidade", with: @client.cidade
    fill_in "Conta", with: @client.conta
    fill_in "Cpf", with: @client.cpf
    fill_in "Documentos", with: @client.documentos
    fill_in "Email", with: @client.email
    fill_in "Empresa atual", with: @client.empresa_atual
    fill_in "Endereco", with: @client.endereco
    fill_in "Estado", with: @client.estado
    fill_in "Estadocivil", with: @client.estadocivil
    fill_in "Genero", with: @client.genero
    fill_in "Mae", with: @client.mae
    fill_in "Nacionalidade", with: @client.nacionalidade
    fill_in "Nascimento", with: @client.nascimento
    fill_in "Nb", with: @client.nb
    fill_in "Nome", with: @client.nome
    fill_in "Profissao", with: @client.profissao
    fill_in "Rg", with: @client.rg
    fill_in "Sobrenome", with: @client.sobrenome
    fill_in "Telefone", with: @client.telefone
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "updating a Client" do
    visit clients_url
    click_on "Edit", match: :first

    fill_in "Agencia", with: @client.agencia
    fill_in "Banco", with: @client.banco
    fill_in "Capacidade", with: @client.capacidade
    fill_in "Cep", with: @client.cep
    fill_in "Cidade", with: @client.cidade
    fill_in "Conta", with: @client.conta
    fill_in "Cpf", with: @client.cpf
    fill_in "Documentos", with: @client.documentos
    fill_in "Email", with: @client.email
    fill_in "Empresa atual", with: @client.empresa_atual
    fill_in "Endereco", with: @client.endereco
    fill_in "Estado", with: @client.estado
    fill_in "Estadocivil", with: @client.estadocivil
    fill_in "Genero", with: @client.genero
    fill_in "Mae", with: @client.mae
    fill_in "Nacionalidade", with: @client.nacionalidade
    fill_in "Nascimento", with: @client.nascimento
    fill_in "Nb", with: @client.nb
    fill_in "Nome", with: @client.nome
    fill_in "Profissao", with: @client.profissao
    fill_in "Rg", with: @client.rg
    fill_in "Sobrenome", with: @client.sobrenome
    fill_in "Telefone", with: @client.telefone
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "destroying a Client" do
    visit clients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client was successfully destroyed"
  end
end
