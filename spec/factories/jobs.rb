# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    description { 'Lorem ipsum dolor' }
    deadline { '2023-02-10' }
    responsable { 'João da Silva' }
    status { 1 }
    client_id { 1 }
    priority { 0 }
    comment { 'Observações escritas aqui' }
    work_id { 1 }
  end
end
