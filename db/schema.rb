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

ActiveRecord::Schema.define(version: 20160312230109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "departments", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.float    "credit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "departments", ["company_id"], name: "index_departments_on_company_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "available_credit"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "company_id"
    t.integer  "department_id"
  end

  add_index "teams", ["company_id"], name: "index_teams_on_company_id", using: :btree
  add_index "teams", ["department_id"], name: "index_teams_on_department_id", using: :btree

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "roles",                  default: ["common"],              array: true
    t.integer  "company_id"
    t.integer  "department_id"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wishes", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "title"
    t.text     "description"
    t.integer  "impact_on_business"
    t.integer  "time_required"
    t.integer  "ease_of_development"
    t.datetime "deadline"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "department_id"
  end

  add_index "wishes", ["department_id"], name: "index_wishes_on_department_id", using: :btree
  add_index "wishes", ["team_id"], name: "index_wishes_on_team_id", using: :btree

  add_foreign_key "departments", "companies"
  add_foreign_key "teams", "companies"
  add_foreign_key "teams", "departments"
  add_foreign_key "users", "companies"
  add_foreign_key "users", "departments"
  add_foreign_key "wishes", "departments"
  add_foreign_key "wishes", "teams"
end
