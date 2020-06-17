# == Schema Information
#
# Table name: escritorios
#
#  id         :bigint           not null, primary key
#  nome       :string
#  oab        :string
#  cnpj       :integer
#  tipo       :integer
#  fundacao   :date
#  endereco   :string
#  cidade     :string
#  estado     :string
#  cep        :integer
#  site       :string
#  telefone   :integer
#  banco      :integer
#  agencia    :integer
#  conta      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Escritorio < ApplicationRecord
end
