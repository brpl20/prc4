require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get clients_url
    assert_response :success
  end

  test "should get new" do
    get new_client_url
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post clients_url, params: { client: { agencia: @client.agencia, banco: @client.banco, capacidade: @client.capacidade, cep: @client.cep, cidade: @client.cidade, conta: @client.conta, cpf: @client.cpf, documentos: @client.documentos, email: @client.email, empresa_atual: @client.empresa_atual, endereco: @client.endereco, estado: @client.estado, estadocivil: @client.estadocivil, genero: @client.genero, mae: @client.mae, nacionalidade: @client.nacionalidade, nascimento: @client.nascimento, nb: @client.nb, nome: @client.nome, profissao: @client.profissao, rg: @client.rg, sobrenome: @client.sobrenome, telefone: @client.telefone } }
    end

    assert_redirected_to client_url(Client.last)
  end

  test "should show client" do
    get client_url(@client)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_url(@client)
    assert_response :success
  end

  test "should update client" do
    patch client_url(@client), params: { client: { agencia: @client.agencia, banco: @client.banco, capacidade: @client.capacidade, cep: @client.cep, cidade: @client.cidade, conta: @client.conta, cpf: @client.cpf, documentos: @client.documentos, email: @client.email, empresa_atual: @client.empresa_atual, endereco: @client.endereco, estado: @client.estado, estadocivil: @client.estadocivil, genero: @client.genero, mae: @client.mae, nacionalidade: @client.nacionalidade, nascimento: @client.nascimento, nb: @client.nb, nome: @client.nome, profissao: @client.profissao, rg: @client.rg, sobrenome: @client.sobrenome, telefone: @client.telefone } }
    assert_redirected_to client_url(@client)
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete client_url(@client)
    end

    assert_redirected_to clients_url
  end
end
