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


b = Lawyer.create(name: "Bruno", lastname: "Pellizzetti", oab_number: "54.159 PR", email: "marcos@pellizzetti.adv.br")
a = Lawyer.create(name: "Marcos", lastname: "Aurélio Ciello", oab_number: "54.837 PR", email: "marcos@pellizzetti.adv.br")
b = Lawyer.create(name: "Eduardo", lastname: "Hamilton Walber", oab_number: "106.344 PR", email: "eduardo@pellizzetti.adv.br")




c = Office.create(name: "Pellizzetti Advocacia", oab: "4416", cnpj_number: "23.583.964/0001-05", society: "Unipessoal", foundation: "Thu, 24 Mar 2016", address: "Rua Paraná, 3033, Ed. Formato, 14 Andar", city: "Cascavel", state: "Paraná", zip: "85810-010", site: "www.pellizzetti.adv.br", telephone: "4530355898", bank: "Sicredi (748)", agency: "0710",  account: "7243-4")

a1 = User.create(email: "marcos@pellizzetti.adv.br", password: 123456, lawyer_role: true)
b1 = User.create(email: "bruno@pellizzetti.adv.br", password: 123456, lawyer_role: true, paralegal_role: true, intern_role: true, secretary_role: true)
c1 = User.create(email: "eduarda@pellizzetti.adv.br", password: 123456, lawyer_role: true)
d1 = User.create(email: "lucas@pellizzetti.adv.br", password: 123456, lawyer_role: true)
e1 = User.create(email: "caroline@pellizzetti.adv.br", password: 123456, lawyer_role: true)
f1 = User.create(email: "aline@pellizzetti.adv.br", password: 123456, lawyer_role: true, paralegal_role: true, intern_role: true, secretary_role: true)
g1 = User.create(email: "valdirene@pellizzetti.adv.br", password: 123456, secretary_role: true)
h1 = User.create(email: "joao@pellizzetti.adv.br", password: 123456, intern_role: true)
i1 = User.create(email: "eduardo@pellizzetti.adv.br", password: 123456, intern_role: true)

val_secretaria = Person.create(first_name: "Valdirene", lastname: "Silva", life: 3)
achp_estagiarai = Person.create(first_name: "Aline", lastname: "Cristina Hoffmann Pereira", life: 1)
