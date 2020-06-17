# == Schema Information
#
# Table name: atendimentos
#
#  id          :bigint           not null, primary key
#  nome        :string
#  sobrenome   :string
#  origem      :string
#  status      :integer
#  responsavel :string
#  telefone    :bigint
#  email       :string
#  assunto     :string
#  notas       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  canal       :string
#
require 'test_helper'

class AtendimentoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
