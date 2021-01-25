# TODO GERAL PROJETO PROC STUDIO

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

## offices

## pages

## users

## works


# Models
_Problemas Gerais dos Models:_
- Como fazer para migrar o _attendence_ para os clientes consolidados com as mesmas informações, inclusive telefone?
- Attendence Has Many Lawyers | Atendimentos Iniciais

<!-- Comentários Jemison -->
- Toda a programação deve ser feita nos models, logo, os controllers apenas realizam chamadas e recebem retorno dos models

## ability (CanCanCan)

## application_Record

## attendance

## bankaccount

## basic

## client
- has_many :phones
- has_many :emails
- accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true
- accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true

## email
- belongs_to :client

## finance

## job

## lawyer

## office

## phone
- belongs_to :client

## user

## work


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

# Banco de dados
- Estou montando um diagrama de entidade-relacionamento sugerindo melhorias na integridade do banco.

- Nas migrations 'offices e clients' a palavra adress deve ser escrita com dois Ds 'address'.
