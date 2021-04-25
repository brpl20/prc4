# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_20_035545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.string "name"
    t.string "lastname"
    t.string "origin"
    t.integer "status"
    t.string "responsible"
    t.string "telephone"
    t.string "email"
    t.string "subject"
    t.string "note"
    t.string "channel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "agency"
    t.string "account"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_banks_on_client_id"
  end

  create_table "checklist_documents", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "checklist_documents_works", id: false, force: :cascade do |t|
    t.bigint "checklist_document_id", null: false
    t.bigint "work_id", null: false
    t.index ["checklist_document_id"], name: "index_checklist_documents_works_on_checklist_document_id"
    t.index ["work_id"], name: "index_checklist_documents_works_on_work_id"
  end

  create_table "checklists", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "checklists_works", id: false, force: :cascade do |t|
    t.bigint "checklist_id", null: false
    t.bigint "work_id", null: false
    t.index ["checklist_id"], name: "index_checklists_works_on_checklist_id"
    t.index ["work_id"], name: "index_checklists_works_on_work_id"
  end

  create_table "client_works", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "work_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_client_works_on_client_id"
    t.index ["work_id"], name: "index_client_works_on_work_id"
  end

  create_table "clients", force: :cascade do |t|
    t.integer "gender"
    t.string "name"
    t.string "lastname"
    t.string "citizenship"
    t.string "civilstatus"
    t.string "capacity"
    t.string "profession"
    t.string "company"
    t.date "birth"
    t.string "mothername"
    t.string "number_benefit"
    t.string "general_register"
    t.string "social_number"
    t.string "email"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "bank"
    t.string "agency"
    t.string "account"
    t.string "zip"
    t.string "telephone"
    t.json "documents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "choice"
  end

  create_table "emails", force: :cascade do |t|
    t.text "email"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_emails_on_client_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.text "description"
    t.string "deadline"
    t.string "responsable"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "clients_id"
    t.index ["clients_id"], name: "index_jobs_on_clients_id"
  end

  create_table "lawyers", force: :cascade do |t|
    t.integer "gender"
    t.string "general_register"
    t.bigint "social_number"
    t.string "oab_number"
    t.string "name"
    t.string "lastname"
    t.string "citizenship"
    t.string "civilstatus"
    t.date "birth"
    t.string "mothername"
    t.string "email"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "telephone"
    t.string "bank"
    t.string "agency"
    t.string "account"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.string "oab"
    t.string "cnpj_number"
    t.string "society"
    t.date "foundation"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "site"
    t.string "telephone"
    t.string "bank"
    t.string "agency"
    t.string "account"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "address"
    t.date "birth"
    t.integer "capacity"
    t.string "citizenship"
    t.string "city"
    t.string "civilstatus"
    t.string "company"
    t.string "email"
    t.string "first_name"
    t.string "lastname"
    t.integer "gender"
    t.string "general_register"
    t.string "mothername"
    t.string "number_benefit"
    t.string "oab_number"
    t.string "profession"
    t.string "social_number"
    t.string "state"
    t.string "zip"
    t.integer "status"
    t.integer "life"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "phones", force: :cascade do |t|
    t.text "phone"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_phones_on_client_id"
  end

  create_table "powers", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "powers_works", id: false, force: :cascade do |t|
    t.bigint "power_id", null: false
    t.bigint "work_id", null: false
  end

  create_table "procedures", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "procedures_works", id: false, force: :cascade do |t|
    t.bigint "procedure_id", null: false
    t.bigint "work_id", null: false
    t.index ["procedure_id"], name: "index_procedures_works_on_procedure_id"
    t.index ["work_id"], name: "index_procedures_works_on_work_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer "type"
    t.string "name"
    t.string "lastname"
    t.integer "gender"
    t.string "general_register"
    t.string "oab"
    t.string "social_number"
    t.string "citizenship"
    t.integer "civilstatus"
    t.date "birth"
    t.string "mothername"
    t.string "email"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "phone"
    t.string "bank"
    t.string "agency"
    t.string "account"
    t.string "zip"
    t.integer "status"
    t.string "origin"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "lawyer_role"
    t.boolean "paralegal_role"
    t.boolean "intern_role"
    t.boolean "secretary_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_offices", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.bigint "office_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["office_id"], name: "index_work_offices_on_office_id"
    t.index ["work_id"], name: "index_work_offices_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.string "subject"
    t.string "action"
    t.string "number"
    t.string "rate_percentage"
    t.string "rate_percentage_exfield"
    t.string "rate_fixed"
    t.string "rate_fixed_exfield"
    t.string "rate_work"
    t.string "rate_parceled"
    t.text "power"
    t.string "recommendation"
    t.string "recommendation_comission"
    t.string "folder"
    t.string "initial_atendee"
    t.string "responsible_lawyer"
    t.string "procuration_lawyer"
    t.string "procuration_intern"
    t.string "procuration_paralegal"
    t.string "partner_lawyer"
    t.text "note"
    t.string "checklist"
    t.string "checklist_document"
    t.string "document_pendent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.json "document"
    t.string "rate_parceled_exfield"
  end

  add_foreign_key "banks", "clients"
  add_foreign_key "client_works", "clients"
  add_foreign_key "client_works", "works"
  add_foreign_key "emails", "clients"
  add_foreign_key "jobs", "clients", column: "clients_id"
  add_foreign_key "phones", "clients"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "work_offices", "offices"
  add_foreign_key "work_offices", "works"
end
