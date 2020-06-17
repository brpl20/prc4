# == Schema Information
#
# Table name: clients
#
#  id            :bigint           not null, primary key
#  genero        :integer
#  nome          :string
#  sobrenome     :string
#  nacionalidade :string
#  estadocivil   :string
#  capacidade    :string
#  profissao     :string
#  empresa_atual :string
#  nascimento    :date
#  mae           :string
#  nb            :integer
#  rg            :string
#  cpf           :bigint
#  email         :string
#  endereco      :string
#  cidade        :string
#  estado        :string
#  banco         :integer
#  agencia       :integer
#  conta         :integer
#  cep           :bigint
#  telefone      :bigint
#  documentos    :json
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
