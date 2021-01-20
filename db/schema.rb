# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_29_011857) do

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
    t.string "adress"
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
    t.string "adress"
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
    t.string "adress"
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

  create_table "phones", force: :cascade do |t|
    t.text "phone"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_phones_on_client_id"
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

  create_table "works", force: :cascade do |t|
    t.string "procedure"
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
  end

  add_foreign_key "emails", "clients"
  add_foreign_key "jobs", "clients", column: "clients_id"
  add_foreign_key "phones", "clients"
end
