# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TODO tr.substitute = sucess
# TODO Compare address function sociedade x lawyer - default equals advogado
#

#arr.each do | base |
#  puts base.join(",")
#end

# Client.all.each do | cliento |
#     arr1.each do | base |
#       puts base[0]
#     end
#   end

# Client.all.each do | cliento |
#     arr1.each do | base |
#     if cliento.id == base[0].to_i
#       Client.id.nome = base[1]
#     end
#   end
# end


# b = Lawyer.create(name: "Bruno", lastname: "Pellizzetti", oab_number: "54.159 PR", email: "marcos@pellizzetti.adv.br")
# a = Lawyer.create(name: "Marcos", lastname: "Aurélio Ciello", oab_number: "54.837 PR", email: "marcos@pellizzetti.adv.br")
# b = Lawyer.create(name: "Eduardo", lastname: "Hamilton Walber", oab_number: "106.344 PR", email: "eduardo@pellizzetti.adv.br")


Office.create(
  name: "Pellizzetti Advocacia",
  oab: "4416",
  cnpj_number: "23.583.964/0001-05",
  society: "Unipessoal",
  foundation: "Thu, 24 Mar 2016",
  address: "Rua Paraná, 3033, Ed. Formato, 14 Andar",
  city: "Cascavel",
  state: "Paraná",
  zip: "85810-010",
  site: "www.pellizzetti.adv.br",
  telephone: "4530355898",
  bank: "Sicredi (748)",
  agency: "0710",
  account: "7243-4"
)

User.create!(
  email: "bruno@pellizzetti.adv.br",
  password: 123456,
  password_confirmation: 123456,
  lawyer_role: true,
  paralegal_role: true,
  intern_role: true,
  secretary_role: true
)

UserProfile.create!(
 id: 1,
 role: 0,
 name: 'Bruno',
 lastname: "Pellizzetti",
 gender: 0,
 general_register: '70599872',
 oab: '54.159',
 social_number: '05880253996',
 citizenship: 'Brasileiro',
 civilstatus: 'Solteiro',
 birth: nil,
 mothername: 'Ivete Goinski Pellizzetti',
 email: 'bruno@pellizzetti.adv.br',
 address: 'Rua Alexandre de Gusmão, 712',
 city: 'Cascavel',
 state: 'Paraná',
 phone: '45984055504',
 bank: 'Sicredi',
 agency: '3935',
 account: '72225',
 zip: '85810-010',
 status: 0,
 origin: nil,
 user_id: 1
 )


User.create!(
  email: "marcos@pellizzetti.adv.br",
  password: 123456,
  password_confirmation: 123456,
  lawyer_role: true
)

UserProfile.create!(
 id: 2,
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
 bank: 'Caixa',
 agency: '3935',
 account: '20598-4',
 zip: '85810-010',
 status: 0,
 origin: nil,
 user_id: 2
 )

# User.create!(
#   email: "lucas@pellizzetti.adv.br",
#   password: 123456,
#   password_confirmation: 123456,
#   lawyer_role: true
# )

User.create!(
  email: "aline@pellizzetti.adv.br",
  password: 123456,
  password_confirmation: 123456,
  intern_role: true
)

UserProfile.create!(
 id: 3,
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
 bank: 'Nubank',
 agency: '001',
 account: '4698150-5',
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
 id: 4,
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
 bank: 'Nubank',
 agency: '001',
 account: '77557156-8',
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
 id: 5,
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
 bank: 'Sicredi',
 agency: '0710',
 account: '63093-1',
 zip: '85806-253',
 status: 0,
 origin: nil,
 user_id: 5
 )

Client.create!(
  gender: 1,
  name: "Bruno",
  lastname: "Pellizzetti",
  citizenship: "Brasileiro",
  civilstatus: "1",
  capacity: "Capaz",
  profession: "Advogado",
  company: "Lzt Advocacia",
  birth: nil,
  mothername: "Ivete Goinski Pellizzetti",
  number_benefit: "",
  general_register: "7059987-2",
  social_number: "058.802.539-96",
  address: "Rua Alexandre de Gusmão, 712",
  city: "Cascavel",
  state: "Paraná",
  bank: nil,
  agency: nil,
  account: nil,
  zip: "85.819-530",
  documents: nil,
)

