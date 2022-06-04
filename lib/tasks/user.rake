namespace :cad do

  desc "Cadastro de Usuários"
  task user: :environment do

    p "Criando usuários do sistema..."

    User.create!(
      email: "bruno@pellizzetti.adv.br",
      password: 123456,
      password_confirmation: 123456,
      lawyer_role: true,
      paralegal_role: true,
      intern_role: true,
      secretary_role: true,
      accountant_role: false,
      outside_accountant_role: false
    )

    UserProfile.create!(
     name: 'Bruno',
     lastname: "Pellizzetti",
     gender: 0,
     general_register: '70599872',
     social_number: '05880253996',
     citizenship: 'Brasileiro',
     civilstatus: 'Solteiro',
     birth: nil,
     mothername: 'Ivete Goinski Pellizzetti',
     address: 'Rua Alexandre de Gusmão, 712',
     city: 'Cascavel',
     state: 'Paraná',
     zip: '85810-010',
     phone: '45984055504',
     email: 'bruno@pellizzetti.adv.br',
     status: 0,
     origin: nil,
     role: 0,
     oab: '54.159',
     user_id: 1
     )

    User.create!(
      email: "marcos@pellizzetti.adv.br",
      password: 123456,
      password_confirmation: 123456,
      lawyer_role: true
    )

    UserProfile.create!(
     role: 0,
     name: 'Marcos',
     lastname: "Aurelio Ciello",
     gender: 0,
     general_register: '6517723-4',
     oab: '54.837',
     social_number: '01711739960',
     citizenship: 'Brasileiro',
     civilstatus: 'Divorciado',
     birth: nil,
     mothername: 'Dirce Parise Ciello',
     email: 'marcos@pellizzetti.adv.br',
     address: 'Rua Das Petúnias, 712, Ap 03',
     city: 'Cascavel',
     state: 'Paraná',
     phone: '45999324267',
     zip: '85810-010',
     status: 0,
     origin: nil,
     user_id: 2
     )

    User.create!(
      email: "aline@pellizzetti.adv.br",
      password: 123456,
      password_confirmation: 123456,
      intern_role: true
    )

    UserProfile.create!(
     role: 2,
     name: 'Aline',
     lastname: "Cristina Hoffmann Pereira",
     gender: 1,
     general_register: '124539242',
     oab: nil,
     social_number: '10951294903',
     citizenship: 'Brasileiro',
     civilstatus: 'Solteiro',
     birth: nil,
     mothername: 'Rosane Hoffmann',
     email: 'aline@pellizzetti.adv.br',
     address: 'Rua Mato Grosso, 2539, Ap. 142',
     city: 'Cascavel',
     state: 'Paraná',
     phone: '4598805-8852',
     zip: '85810-010',
     status: 0,
     origin: nil,
     user_id: 3
     )

    User.create!(
      email: "valdirene@pellizzetti.adv.br",
      password: 123456,
      password_confirmation: 123456,
      secretary_role: true
    )

    UserProfile.create!(
     role: 3,
     name: 'Valdirene',
     lastname: "Santos da Costa Silva",
     gender: 1,
     general_register: '73711754',
     oab: nil,
     social_number: '02994736942',
     citizenship: 'Brasileiro',
     civilstatus: 'Casado',
     birth: nil,
     mothername: 'Constancia dos Santos',
     email: 'valdirene@pellizzetti.adv.br',
     address: 'Rua Fortunato Bebber, 1651',
     city: 'Cascavel',
     state: 'Paraná',
     phone: '4599919-5002',
     zip: '85816-300',
     status: 0,
     origin: nil,
     user_id: 4
     )

    User.create!(
      email: "joao@pellizzetti.adv.br",
      password: 123456,
      password_confirmation: 123456,
      paralegal_role: true
    )

    UserProfile.create!(
     role: 1,
     name: 'João',
     lastname: "Augusto Prado",
     gender: 0,
     general_register: "99897961",
     oab: nil,
     social_number: '08039195900',
     citizenship: 'Brasileiro',
     civilstatus: 'União Estável',
     birth: nil,
     mothername: 'Rosinha Mendes Prado',
     email: 'joao@pellizzetti.adv.br',
     address: 'Rua Carajás, 2216',
     city: 'Cascavel',
     state: 'Paraná',
     phone: '4599853-4569',
     zip: '85806-253',
     status: 0,
     origin: nil,
     user_id: 5
     )

    p 'Usuários do sistema criados com sucesso'
  end

end