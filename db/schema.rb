# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_16_003559) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atendimentos", force: :cascade do |t|
    t.string "nome"
    t.string "sobrenome"
    t.string "origem"
    t.integer "status"
    t.string "responsavel"
    t.bigint "telefone"
    t.string "email"
    t.string "assunto"
    t.string "notas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "canal"
  end

  create_table "basics", force: :cascade do |t|
    t.string "checklist"
    t.string "poderes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.integer "genero"
    t.string "nome"
    t.string "sobrenome"
    t.string "nacionalidade"
    t.string "estadocivil"
    t.string "capacidade"
    t.string "profissao"
    t.string "empresa_atual"
    t.date "nascimento"
    t.string "mae"
    t.bigint "nb"
    t.string "rg"
    t.bigint "cpf"
    t.string "email"
    t.string "endereco"
    t.string "cidade"
    t.string "estado"
    t.integer "banco"
    t.integer "agencia"
    t.integer "conta"
    t.bigint "cep"
    t.bigint "telefone"
    t.json "documentos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "escolha"
  end

  create_table "escritorios", force: :cascade do |t|
    t.string "nome"
    t.string "oab"
    t.integer "cnpj"
    t.integer "tipo"
    t.date "fundacao"
    t.string "endereco"
    t.string "cidade"
    t.string "estado"
    t.integer "cep"
    t.string "site"
    t.integer "telefone"
    t.integer "banco"
    t.integer "agencia"
    t.integer "conta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.text "descricao"
    t.string "prazo"
    t.string "responsavel"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "clients_id"
    t.index ["clients_id"], name: "index_jobs_on_clients_id"
  end

  create_table "lawyers", force: :cascade do |t|
    t.integer "genero"
    t.string "rg"
    t.bigint "cpf"
    t.string "oab"
    t.string "nome"
    t.string "sobrenome"
    t.string "nacionalidade"
    t.string "estadocivil"
    t.date "nascimento"
    t.string "mae"
    t.string "email"
    t.string "endereco"
    t.string "cidade"
    t.string "estado"
    t.bigint "telefone"
    t.integer "banco"
    t.integer "agencia"
    t.bigint "conta"
    t.bigint "cep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lawyer_role"
    t.boolean "paralegal_role"
    t.boolean "intern_role"
    t.boolean "secretary_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "works", force: :cascade do |t|
    t.string "tipo"
    t.string "materia"
    t.string "acao"
    t.integer "numero"
    t.string "honorariosp"
    t.string "honorariosp_exfield"
    t.string "honorariosf"
    t.string "honorariosf_exfield"
    t.string "honorarios_trab_x_exito"
    t.string "honorarios_parcelamento"
    t.string "escritorio"
    t.text "poderes"
    t.string "indicacao"
    t.string "indicacao_comissao"
    t.string "pasta"
    t.string "atendimento_inicial"
    t.string "advogado_responsavel"
    t.string "advogado_procuracao"
    t.string "estagiarios_procuracao"
    t.string "paralegais_procuracao"
    t.string "advogado_parceiro"
    t.text "notas"
    t.string "checklist"
    t.string "checklist_documentos"
    t.string "documentos_pendentes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "jobs", "clients", column: "clients_id"
end
