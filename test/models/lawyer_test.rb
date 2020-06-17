# == Schema Information
#
# Table name: lawyers
#
#  id            :bigint           not null, primary key
#  genero        :integer
#  rg            :string
#  cpf           :bigint
#  oab           :string
#  nome          :string
#  sobrenome     :string
#  nacionalidade :string
#  estadocivil   :string
#  nascimento    :date
#  mae           :string
#  email         :string
#  endereco      :string
#  cidade        :string
#  estado        :string
#  telefone      :bigint
#  banco         :integer
#  agencia       :integer
#  conta         :bigint
#  cep           :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'test_helper'

class LawyerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
