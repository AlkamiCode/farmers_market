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

ActiveRecord::Schema.define(version: 20150826172322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "type_of"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "city"
    t.text     "state"
    t.text     "zip_code"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "slug"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

  create_table "category_stores", force: :cascade do |t|
    t.integer "store_id"
    t.integer "category_id"
  end

  add_index "category_stores", ["category_id"], name: "index_category_stores_on_category_id", using: :btree
  add_index "category_stores", ["store_id"], name: "index_category_stores_on_store_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "unit_price", precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "category_id"
    t.text     "name"
    t.text     "description"
    t.text     "image_url"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "status",                              default: 0
    t.integer  "store_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["status"], name: "index_products_on_status", using: :btree
  add_index "products", ["store_id"], name: "index_products_on_store_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string  "farm_name"
    t.string  "facebook_url"
    t.string  "photo_url"
    t.string  "twitter_url"
    t.string  "instagram_url"
    t.string  "description"
    t.string  "url"
    t.integer "user_id"
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password_digest"
    t.text     "first_name"
    t.text     "last_name"
    t.integer  "role",            default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "category_stores", "categories"
  add_foreign_key "category_stores", "stores"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "stores"
  add_foreign_key "stores", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
