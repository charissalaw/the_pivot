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

ActiveRecord::Schema.define(version: 20160330215258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "borrower_attributes", force: :cascade do |t|
    t.string   "category"
    t.string   "label"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "borrowers", force: :cascade do |t|
    t.integer  "annual_income"
    t.integer  "monthly_housing"
    t.integer  "monthly_credit_pmt"
    t.integer  "dependents"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "borrowers", ["user_id"], name: "index_borrowers_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "countries", ["slug"], name: "index_countries_on_slug", using: :btree

  create_table "escrows", force: :cascade do |t|
    t.integer  "debt_amount", default: 0
    t.integer  "project_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "escrows", ["project_id"], name: "index_escrows_on_project_id", using: :btree

  create_table "loans", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "status",     default: "active"
  end

  add_index "loans", ["order_id"], name: "index_loans_on_order_id", using: :btree
  add_index "loans", ["project_id"], name: "index_loans_on_project_id", using: :btree

  create_table "mailing_list_emails", force: :cascade do |t|
    t.string "email"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "status",      default: "escrow"
    t.string   "card_token"
    t.integer  "order_total"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "goal"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "borrower_id"
    t.integer  "country_id"
    t.string   "slug"
    t.string   "status",             default: "active"
  end

  add_index "projects", ["borrower_id"], name: "index_projects_on_borrower_id", using: :btree
  add_index "projects", ["category_id"], name: "index_projects_on_category_id", using: :btree
  add_index "projects", ["country_id"], name: "index_projects_on_country_id", using: :btree
  add_index "projects", ["slug"], name: "index_projects_on_slug", using: :btree

  create_table "repayments", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "amount_paid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "stripeToken"
  end

  add_index "repayments", ["project_id"], name: "index_repayments_on_project_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "fullname"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  add_foreign_key "borrowers", "users"
  add_foreign_key "escrows", "projects"
  add_foreign_key "loans", "orders"
  add_foreign_key "loans", "projects"
  add_foreign_key "orders", "users"
  add_foreign_key "projects", "borrowers"
  add_foreign_key "projects", "categories"
  add_foreign_key "projects", "countries"
  add_foreign_key "repayments", "projects"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
