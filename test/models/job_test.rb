# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  descricao   :text
#  prazo       :string
#  responsavel :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  clients_id  :bigint
#
require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
