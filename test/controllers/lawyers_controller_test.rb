require 'test_helper'

class LawyersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lawyer = lawyers(:one)
  end

  test "should get index" do
    get lawyers_url
    assert_response :success
  end

  test "should get new" do
    get new_lawyer_url
    assert_response :success
  end

  test "should create lawyer" do
    assert_difference('Lawyer.count') do
      post lawyers_url, params: { lawyer: { agencia: @lawyer.agencia, banco: @lawyer.banco, cep: @lawyer.cep, cidade: @lawyer.cidade, conta: @lawyer.conta, cpf: @lawyer.cpf, email: @lawyer.email, endereco: @lawyer.endereco, estado: @lawyer.estado, estadocivil: @lawyer.estadocivil, genero: @lawyer.genero, mae: @lawyer.mae, nacionalidade: @lawyer.nacionalidade, nascimento: @lawyer.nascimento, nome: @lawyer.nome, oab: @lawyer.oab, rg: @lawyer.rg, sobrenome: @lawyer.sobrenome, telefone: @lawyer.telefone } }
    end

    assert_redirected_to lawyer_url(Lawyer.last)
  end

  test "should show lawyer" do
    get lawyer_url(@lawyer)
    assert_response :success
  end

  test "should get edit" do
    get edit_lawyer_url(@lawyer)
    assert_response :success
  end

  test "should update lawyer" do
    patch lawyer_url(@lawyer), params: { lawyer: { agencia: @lawyer.agencia, banco: @lawyer.banco, cep: @lawyer.cep, cidade: @lawyer.cidade, conta: @lawyer.conta, cpf: @lawyer.cpf, email: @lawyer.email, endereco: @lawyer.endereco, estado: @lawyer.estado, estadocivil: @lawyer.estadocivil, genero: @lawyer.genero, mae: @lawyer.mae, nacionalidade: @lawyer.nacionalidade, nascimento: @lawyer.nascimento, nome: @lawyer.nome, oab: @lawyer.oab, rg: @lawyer.rg, sobrenome: @lawyer.sobrenome, telefone: @lawyer.telefone } }
    assert_redirected_to lawyer_url(@lawyer)
  end

  test "should destroy lawyer" do
    assert_difference('Lawyer.count', -1) do
      delete lawyer_url(@lawyer)
    end

    assert_redirected_to lawyers_url
  end
end
