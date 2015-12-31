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

ActiveRecord::Schema.define(version: 20150909024035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "databases", force: :cascade do |t|
    t.string   "name"
    t.string   "database"
    t.string   "adapter"
    t.string   "host"
    t.string   "port"
    t.string   "encrypted_username"
    t.string   "encrypted_password"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "field_types", force: :cascade do |t|
    t.string   "name"
    t.string   "data_type"
    t.string   "valid_regex"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name"
    t.integer  "field_type_id"
    t.integer  "report_type_id"
    t.boolean  "required"
    t.string   "placeholder"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "fields", ["field_type_id"], name: "index_fields_on_field_type_id", using: :btree
  add_index "fields", ["report_type_id"], name: "index_fields_on_report_type_id", using: :btree

  create_table "report_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "database_id"
    t.text     "description"
    t.text     "sql"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "report_types", ["category_id"], name: "index_report_types_on_category_id", using: :btree
  add_index "report_types", ["database_id"], name: "index_report_types_on_database_id", using: :btree

  add_foreign_key "fields", "field_types"
  add_foreign_key "fields", "report_types"
  add_foreign_key "report_types", "categories"
  add_foreign_key "report_types", "databases"
end
