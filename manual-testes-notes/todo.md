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

# Usuários do Sistema
- User = role
- Users ... Terminal Campos

# Recursos em Geral
- Arrumar Action Mail para enviar e-mails administrativos de controle

# Controllers
_Problemas Gerais dos Controllers:_

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

## ability (CanCanCan)

## application_Record

## attendance

## bankaccount

## basic

## client

## email

## finance

## job

## lawyer

## office

## phone

## user

## work


# Views
_Problemas Gerais das Views:_
- Arrumar mensagens de erros ?
- Refazer Json Builder
<!-- - Excluir JSON Builder  -->

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
