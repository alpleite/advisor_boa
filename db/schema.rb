# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151007165050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allotments", force: :cascade do |t|
    t.string   "name"
    t.integer  "consumers_id"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "token"
  end

  add_index "allotments", ["consumers_id"], name: "index_allotments_on_consumers_id", using: :btree

  create_table "claro_extracts", force: :cascade do |t|
    t.integer  "line"
    t.string   "content"
    t.integer  "allotment_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "id_file"
  end

  add_index "claro_extracts", ["allotment_id"], name: "index_claro_extracts_on_allotment_id", using: :btree

  create_table "claro_manager_by_lines", force: :cascade do |t|
    t.string   "kind"
    t.string   "item"
    t.decimal  "value",        precision: 8, scale: 2
    t.integer  "allotment_id"
    t.string   "id_file"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "claro_transaction_by_line_claros", force: :cascade do |t|
    t.string   "name"
    t.string   "kind"
    t.decimal  "value",        precision: 8, scale: 2
    t.integer  "allotment_id"
    t.string   "id_file"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "use_time",     precision: 8, scale: 2
  end

  create_table "claro_transaction_by_lines", force: :cascade do |t|
    t.string   "name"
    t.string   "kind"
    t.decimal  "value",         precision: 8, scale: 2
    t.decimal  "use_time",      precision: 8, scale: 2
    t.integer  "allotment_id"
    t.string   "id_file"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.decimal  "valor_total",   precision: 8, scale: 2
    t.decimal  "valor_cobrado", precision: 8, scale: 2
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "type_companies_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "companies", ["type_companies_id"], name: "index_companies_on_type_companies_id", using: :btree

  create_table "consumers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "header_manager_claros", force: :cascade do |t|
    t.string   "name"
    t.string   "item"
    t.string   "tipo"
    t.decimal  "value",        precision: 8, scale: 2
    t.decimal  "decimal",      precision: 8, scale: 2
    t.integer  "allotment_id"
    t.string   "id_file"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "pdf_files", force: :cascade do |t|
    t.string   "name"
    t.string   "path"
    t.integer  "allotments_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "pdf_file_id"
    t.integer  "company_id"
  end

  add_index "pdf_files", ["allotments_id"], name: "index_pdf_files_on_allotments_id", using: :btree
  add_index "pdf_files", ["company_id"], name: "index_pdf_files_on_company_id", using: :btree

  create_table "type_companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vivo_extracts", force: :cascade do |t|
    t.integer  "allotment_id"
    t.integer  "pdf_file_id"
    t.integer  "line"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "vivo_extracts", ["allotment_id"], name: "index_vivo_extracts_on_allotment_id", using: :btree
  add_index "vivo_extracts", ["pdf_file_id"], name: "index_vivo_extracts_on_pdf_file_id", using: :btree

  create_table "vivo_group_words", force: :cascade do |t|
    t.string   "name"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vivo_header_managers", force: :cascade do |t|
    t.integer  "allotment_id"
    t.integer  "pdf_file_id"
    t.string   "item"
    t.integer  "number_of_lines"
    t.integer  "amount_of_plans"
    t.decimal  "contracted_amount",  precision: 8, scale: 2
    t.string   "contracted_service"
    t.string   "service_used"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "enclosed"
    t.integer  "type_enclosed"
    t.integer  "utilized"
    t.integer  "type_utilized"
  end

  add_index "vivo_header_managers", ["allotment_id"], name: "index_vivo_header_managers_on_allotment_id", using: :btree
  add_index "vivo_header_managers", ["pdf_file_id"], name: "index_vivo_header_managers_on_pdf_file_id", using: :btree

  create_table "vivo_transation_by_lines", force: :cascade do |t|
    t.string   "name"
    t.decimal  "amount",       precision: 8, scale: 2
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "allotment_id"
    t.integer  "pdf_file_id"
  end

  add_index "vivo_transation_by_lines", ["allotment_id"], name: "index_vivo_transation_by_lines_on_allotment_id", using: :btree
  add_index "vivo_transation_by_lines", ["pdf_file_id"], name: "index_vivo_transation_by_lines_on_pdf_file_id", using: :btree

  add_foreign_key "allotments", "consumers", column: "consumers_id"
  add_foreign_key "companies", "type_companies", column: "type_companies_id"
  add_foreign_key "pdf_files", "allotments", column: "allotments_id"
  add_foreign_key "pdf_files", "companies"
  add_foreign_key "vivo_extracts", "allotments"
  add_foreign_key "vivo_extracts", "pdf_files"
  add_foreign_key "vivo_header_managers", "allotments"
  add_foreign_key "vivo_header_managers", "pdf_files"
  add_foreign_key "vivo_transation_by_lines", "allotments"
  add_foreign_key "vivo_transation_by_lines", "pdf_files"
end
