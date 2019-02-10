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

ActiveRecord::Schema.define(version: 2019_02_10_152318) do

  create_table "addresses", force: :cascade do |t|
    t.string "address", limit: 120
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "assemblies", force: :cascade do |t|
    t.integer "product_id"
    t.integer "material_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_assemblies_on_material_id"
    t.index ["product_id"], name: "index_assemblies_on_product_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 60
    t.string "slug", limit: 60
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code", limit: 3
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
    t.index ["user_id"], name: "index_currencies_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", limit: 45
    t.string "phone", limit: 13
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "address_id"
    t.index ["address_id"], name: "index_customers_on_address_id"
  end

  create_table "depreciations", force: :cascade do |t|
    t.string "note", limit: 255
    t.integer "amount"
    t.integer "quantity"
    t.integer "provider_id"
    t.integer "material_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_depreciations_on_material_id"
    t.index ["provider_id"], name: "index_depreciations_on_provider_id"
    t.index ["user_id"], name: "index_depreciations_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "number", limit: 16
    t.integer "termin", limit: 2
    t.integer "currency_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_id"
    t.index ["currency_id"], name: "index_invoices_on_currency_id"
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "manifests", force: :cascade do |t|
    t.integer "manufacture_id"
    t.integer "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacture_id"], name: "index_manifests_on_manufacture_id"
    t.index ["product_id"], name: "index_manifests_on_product_id"
  end

  create_table "manufactures", force: :cascade do |t|
    t.integer "user_id"
    t.string "code", limit: 16
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_manufactures_on_code", unique: true
    t.index ["user_id"], name: "index_manufactures_on_user_id"
  end

  create_table "material_purchases", force: :cascade do |t|
    t.integer "material_id"
    t.integer "purchase_id"
    t.integer "price"
    t.integer "quantity"
    t.index ["material_id"], name: "index_material_purchases_on_material_id"
    t.index ["purchase_id"], name: "index_material_purchases_on_purchase_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name", limit: 120
    t.string "slug", limit: 120
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_materials_on_slug", unique: true
  end

  create_table "materials_providers", id: false, force: :cascade do |t|
    t.integer "material_id"
    t.integer "provider_id"
    t.index ["material_id"], name: "index_materials_providers_on_material_id"
    t.index ["provider_id"], name: "index_materials_providers_on_provider_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "price"
    t.integer "number"
    t.boolean "canceled"
    t.integer "user_id"
    t.integer "address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_orders_on_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "prices", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "material_id"
    t.integer "provider_id"
    t.index ["material_id"], name: "index_prices_on_material_id"
    t.index ["provider_id"], name: "index_prices_on_provider_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "code", limit: 10
    t.string "name", limit: 60
    t.string "serial_number", limit: 15
    t.integer "price"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stock"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["code"], name: "index_products_on_code", unique: true
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", limit: 120
    t.string "slug", limit: 120
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_providers_on_slug", unique: true
  end

  create_table "purchases", force: :cascade do |t|
    t.string "invoice", limit: 150
    t.integer "amount"
    t.string "note", limit: 255
    t.datetime "purchased_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "provider_id"
    t.integer "user_id"
    t.index ["provider_id"], name: "index_purchases_on_provider_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 20
    t.string "display_name", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 45
    t.string "email", limit: 45
    t.string "password_digest", limit: 72
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secret", limit: 60
    t.integer "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
