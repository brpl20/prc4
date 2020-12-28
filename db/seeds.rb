# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# TODO tr.substitute = sucess
# TODO Compare adress function sociedade x lawyer - default equals advogado
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

# lawyer = Lawyer.create
#     (
#     [
#       { nome: "Marcos", sobrenome: "Aurélio Ciello", oab: "54.837 PR", email: "marcos@pellizzetti.adv.br"  },
#       { nome: "Bruno", sobrenome: "Pellizzetti", oab: "54.159 PR", email: "marcos@pellizzetti.adv.br"  }
#     ]
#     )

a = Lawyer.create(name: "Marcos", lastname: "Aurélio Ciello", oab_number: "54.837 PR", email: "marcos@pellizzetti.adv.br")
b = Lawyer.create(name: "Bruno", lastname: "Pellizzetti", oab_number: "54.159 PR", email: "marcos@pellizzetti.adv.br")


a1 = User.create(email: "marcos@pellizzetti.adv.br", password: 123456, lawyer_role: true)
b1 = User.create(email: "bruno@pellizzetti.adv.br", password: 123456, lawyer_role: true, paralegal_role: true, intern_role: true, secretary_role: true)
c1 = User.create(email: "eduarda@pellizzetti.adv.br", password: 123456, lawyer_role: true)
d1 = User.create(email: "lucas@pellizzetti.adv.br", password: 123456, lawyer_role: true)
e1 = User.create(email: "caroline@pellizzetti.adv.br", password: 123456, lawyer_role: true)
f1 = User.create(email: "aline@pellizzetti.adv.br", password: 123456, lawyer_role: true, paralegal_role: true, intern_role: true, secretary_role: true)
g1 = User.create(email: "valdirene@pellizzetti.adv.br", password: 123456, secretary_role: true)
h1 = User.create(email: "joao@pellizzetti.adv.br", password: 123456, intern_role: true)
i1 = User.create(email: "eduardo@pellizzetti.adv.br", password: 123456, intern_role: true)


