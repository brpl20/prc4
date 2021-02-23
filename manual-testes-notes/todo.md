# TODO GERAL PROJETO PROC STUDIO

* Adicionar rate_parceled_exfield

## Descrição Geral -- Jemison
- A ideia principal do gerenciamento do escritório é criar um aplicativo baseado nos clientes, assim gostaria que o Model Works gerasse um trabalho, que poderá ter vários Jobs. Works belongs to Clients . Jobs Belongs to Works. UM exemplo. O cliente Bruno tem 1 Work, um processo por exemplo, neste work temos 5 tarefas a serem realizadas, ou seja, 5 jobs.

- Arrumar o action mail

- Criar um .js para limpar o formulário do _works_.

# Modelos
- Melhorar o tr.
- Arrumar a Gem para buscar os campos no arquivo

## Modelos Pendentes
- Contrato de Honorários
- Petições Iniciais

# APIs
- Google Auth + Integração Google
  - Salvar Contato
  - Calendar

# Routes
## Não lembro porque a gente fez essa rota:
```
  resources :clients do
    get 'receipt'
  end
```
- 'receipt' foi criada para a geração de recibos no sistema. Ela gera a rota client_receipt_path(@client) que pode ser utilizada por meio do model cliente, no arquivo já existente 'views/clients/receipt.html.erb', basta apenas criar um método 'receipt' na clients_controller.

# Usuários do Sistema
- User = role
- Users ... Terminal Campos

# Recursos em Geral
- Arrumar Action Mail para enviar e-mails administrativos de controle

# Controllers
_Problemas Gerais dos Controllers:_

- Os métodos que não vão realizar chamadas em Json podem ter o 'respond_to do |format| end' removido e ficar apena o código no método sem o trecho 'format.html{}'.

## application

## attendences

## basics

## clients
- Revisão Geral
<!-- - Tirar lógicas do Recibo -->
- Tirar Repetição dos tr.substitute

## finances

## jobs

## lawyers
- adicionar UF na OAB --> Campo separado
- Mais de uma OAB
- Se pertencer a um escritório ? Relations ?
- Usar o mesmo endereço do escritório
- Usar mesmo e-mail do escritório ?
- Birth - ARrumar campos de idade
-

## offices
- Diminuir campos de Fundação (somente antes de TODAY)

## pages

## users

## works


# Models
_Problemas Gerais dos Models:_
- Como fazer para migrar o _attendence_ para os clientes consolidados com as mesmas informações, inclusive telefone?
- Attendence Has Many Lawyers | Atendimentos Iniciais

<!-- Comentários Jemison -->
- Toda a programação deve ser feita nos models, logo, os controllers apenas realizam chamadas e recebem retorno dos models

* **Algo importante a considerar** (tenha a imagem do diagrama aberta para melhor compreenção): quando temos uma relação de N para N como por exemplo de Client pra Works, onde: um Cliente pode ter vários works e um Work pode conter mais de um Cliente, ocorre a chamada relação ternária. Significa então que será necessário criar uma terceira tabela que geralmente tem o nome dado por 'primeiraTabela_segundaTabela'. Esta tabela resultante de Client e Work conterá dados como client_id: integer e work_id: integer, podendo também conter mais atributos que não se encaixem nas duas tabelas de origem. Agora pra programar isso no Rails temos duas formas e elas dependem de como você pretende estruturar essa terceira tabela. Idem para as tabelas work_office e job_user.

**Primeira forma:** a tabela conterá apenas as chaves estrangeiras **client_id** e **work_id**
Nesta situação você cria apenas uma migration para a tabela nova (não haverá um model novo para Client_work):
```ruby
rails g migration clientWork client:references work:references
rake db:migrate
```
em app/models/client.rb
```ruby
class Client < ApplicationRecord
  has_and_belong_to_many :works
end
```

em app/models/work.rb
```ruby
class Work < ApplicationRecord
  has_and_belong_to_many :clients
  accepts_nested_attributes_for :clients, reject_if: :all_blank, allow_destroy: true
end
```

em app/controllers/works_controller.rb permita o novo atributo no método work_params:
``` ruby
clients_attributes: [:id, :client]
```

nas suas view de Work pode utilizar o fields_for normalmente para informar quem é o client:

```ruby
<%= f.fields_for :client_works do |a| %>
    <%= f.text_field :client_id %>
<% end %>
```

**Segunda forma:** você pode criar um model para ClientWork e fazer uma associação has many como já fez em outros modelos. Apenas não gere as views por que não rpecisará delas uma vez que o cliente será informado em um Work.

## ability (CanCanCan)

## application_Record

## attendance

## bankaccount

## basic

## client
- has_and_belong_to_many :works
- has_many :phones
- has_many :emails
- accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
- accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true

## email
- belongs_to :client

## finance

## job
- belongs_to :work
- has_and_belong_to_many :users

## lawyer

## office

## phone
- belongs_to :client

## user
- has_and_belong_to_many :jobs

## work
- has_many :works
- has_and_belong_to_many :clients
- accepts_nested_attributes_for :clients, reject_if: :all_blank, allow_destroy: true
- accepts_nested_attributes_for :jobs, reject_if: :all_blank, allow_destroy: true

# Views
_Problemas Gerais das Views:_
- Arrumar mensagens de erros ?
- Refazer Json Builder
<!-- - Excluir JSON Builder  -->
<!-- Anotações Jemison -->
- Os itens que cito abaixo e deixo o link da documentação, são algumas sugestões de melhorias que caso queira implementar posso fazer vídeos e te enviar para que entenda a aplicação da sugestão dentro do projeto. (ou qualquer outro item também caso deseje).

- Organização da árvore de arquivos: Para melhorar a organização do projeto e compreender a localização dos arquivos, sugiro criar uma pasta chamada 'shared' em cada pasta das views, assim as 'partials' estarão agrupadas. (isso só não pode ser feito com as partials da gem cocoon por ela não localizaria os arquivos). Ex: Clients >> Shared >> form.html.rb

- Organização de formulários: a partir do rails 5.2 temos o 'form_with' ele permite a criação e formulários com mais dinamicidade do que por exemplo o simple_form_for ou o form_for ou mesmo o form_tag. Esses modelos de formulários com o passar do tempo serão descontinuados pelo rails, então vale a pena começar a utilizar ele, segue link da documentação: https://api.rubyonrails.org/classes/ActionView/Helpers/FormHelper.html#method-i-form_with

- Utilização de Enums: Para seletores fixos ou com pouca alteração como por exemplo: sexo do cliente, estado civil ou status de um processo, sugiro a utilização de enums, pois eles fornecem métodos para verificação de valores e ajudam a reduzir a quantidade de código implementado, reduz a quantidade de bits salvos no banco de dados deixando mais adequado ao modelo relacional e por consequência auxiliando no desempenho de carreamento das páginas. Segue link da documentação: https://api.rubyonrails.org/v5.2.4.4/classes/ActiveRecord/Enum.html

## attendences
- show => criar um cliente, precisamos que ele vá com os params corretos, não está preenchendo o formulário

## clients
- **Possibilidade** de selecionar um ```Attendence.id``` para dar início no form.

## financeiros

## jobs

## offices

## receipt

## users

## works

## layouts
## pages
## shared

<<<<<<< HEAD

# Organizar
## ProcStudio
/index                : Está acessível a lista de clientes para qq pessoa
/index                : Criar Página Inicial

- pages/dashboard     : Quase não dá para retornar no dashbord
- pages/dashboard     : Novo advogado  - não está funcionando

- /offices/new        : Não está funcionando direito --- formulário feio

- /attendances        : Botão de Voltar
- /attendances/new    : Traduções do View
- /attendances        : Traduções do View
- /attendences/1      : Criar Jobs a partir deste

- modelos: /base/procuracao_simples.docx : arrumar fontes : advogados e estagiários : configs (?)

- /clients            : Melhorar a view pq está muito confuso
- /clients            : Traduzir show/edit/destroy (em geral todos eles)

- /clientes/new       : Não vai para view, vai para a Edit
- /clientes/new       : Não gera procuração complexa, apenas a simples

- /clients/2          : Criar Recibo
- /clients/2          : Não atualiza a procuração quando atualiza dados - só dá uma mensagem
- /clients/2          : Ver se data está sendo atualizada - acho que não
- /clients/2          : Genero está 1/2 -- passar para masculino / feminino
- /clients/2          : new job não funciona
- /clients/2          : falta "Works Pendentes"
- /clients/2          : criar "works" está infernal --- muita coisa para ser melhorada
- /clients/2          : Adicionar número do cliente
- /clients/2          : melhorar frontend

- /works               : Não dá pra selecionar a lista de clientes

- /clients/new        : Cep Atualização
- /clients/new        : Adicionar Js
- /clients/new        : Adicionar vários fields --- Email e Contatos diversos
- /clients/new        : Adicionar vários fields --- Capacidade e Ramificações
- /clients/new        : Traduzir campos de banco
- Criar Segundo Documento -> Recibo
- Criar Fluxo de Documentacao

- Send Doc to PDF / Unique and not listed link /
- Join .docx
- Novo Contrato .docx
- Assinador
- E-Mail Listener (Gmail) do append
- Session ... -> Check
=======
# Banco de dados
- Estou montando um diagrama de entidade-relacionamento sugerindo melhorias na integridade do banco.

- Nas migrations 'offices e clients' a palavra adress deve ser escrita com dois Ds 'address'.
>>>>>>> 10a96989803be4aa038ec4a373a7181605e7925d
