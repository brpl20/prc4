require 'test_helper'

class EscritoriosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @escritorio = escritorios(:one)
  end

  test "should get index" do
    get escritorios_url
    assert_response :success
  end

  test "should get new" do
    get new_escritorio_url
    assert_response :success
  end

  test "should create escritorio" do
    assert_difference('Escritorio.count') do
      post escritorios_url, params: { escritorio: { agencia: @escritorio.agencia, banco: @escritorio.banco, cep: @escritorio.cep, cidade: @escritorio.cidade, cnpj: @escritorio.cnpj, conta: @escritorio.conta, endereco: @escritorio.endereco, estado: @escritorio.estado, fundacao: @escritorio.fundacao, nome: @escritorio.nome, oab: @escritorio.oab, site: @escritorio.site, telefone: @escritorio.telefone, tipo: @escritorio.tipo } }
    end

    assert_redirected_to escritorio_url(Escritorio.last)
  end

  test "should show escritorio" do
    get escritorio_url(@escritorio)
    assert_response :success
  end

  test "should get edit" do
    get edit_escritorio_url(@escritorio)
    assert_response :success
  end

  test "should update escritorio" do
    patch escritorio_url(@escritorio), params: { escritorio: { agencia: @escritorio.agencia, banco: @escritorio.banco, cep: @escritorio.cep, cidade: @escritorio.cidade, cnpj: @escritorio.cnpj, conta: @escritorio.conta, endereco: @escritorio.endereco, estado: @escritorio.estado, fundacao: @escritorio.fundacao, nome: @escritorio.nome, oab: @escritorio.oab, site: @escritorio.site, telefone: @escritorio.telefone, tipo: @escritorio.tipo } }
    assert_redirected_to escritorio_url(@escritorio)
  end

  test "should destroy escritorio" do
    assert_difference('Escritorio.count', -1) do
      delete escritorio_url(@escritorio)
    end

    assert_redirected_to escritorios_url
  end
end
