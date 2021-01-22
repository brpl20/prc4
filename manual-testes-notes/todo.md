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

