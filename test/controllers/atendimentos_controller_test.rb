require 'test_helper'

class AtendimentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @atendimento = atendimentos(:one)
  end

  test "should get index" do
    get atendimentos_url
    assert_response :success
  end

  test "should get new" do
    get new_atendimento_url
    assert_response :success
  end

  test "should create atendimento" do
    assert_difference('Atendimento.count') do
      post atendimentos_url, params: { atendimento: { assunto: @atendimento.assunto, email: @atendimento.email, nome: @atendimento.nome, notas: @atendimento.notas, origem: @atendimento.origem, responsavel: @atendimento.responsavel, sobrenome: @atendimento.sobrenome, status: @atendimento.status, telefone: @atendimento.telefone } }
    end

    assert_redirected_to atendimento_url(Atendimento.last)
  end

  test "should show atendimento" do
    get atendimento_url(@atendimento)
    assert_response :success
  end

  test "should get edit" do
    get edit_atendimento_url(@atendimento)
    assert_response :success
  end

  test "should update atendimento" do
    patch atendimento_url(@atendimento), params: { atendimento: { assunto: @atendimento.assunto, email: @atendimento.email, nome: @atendimento.nome, notas: @atendimento.notas, origem: @atendimento.origem, responsavel: @atendimento.responsavel, sobrenome: @atendimento.sobrenome, status: @atendimento.status, telefone: @atendimento.telefone } }
    assert_redirected_to atendimento_url(@atendimento)
  end

  test "should destroy atendimento" do
    assert_difference('Atendimento.count', -1) do
      delete atendimento_url(@atendimento)
    end

    assert_redirected_to atendimentos_url
  end
end
