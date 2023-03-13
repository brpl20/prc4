# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:job) { create(:job) }

  describe 'Casos de erro:' do
    context 'Verificações:' do
      it 'cliente não pode ser inválido.' do
        expect { job.save! }.to raise_error
      end
    end
  end
end
