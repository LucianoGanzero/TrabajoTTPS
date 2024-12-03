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

ActiveRecord::Schema[8.0].define(version: 2024_12_03_221014) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_sizes", id: false, force: :cascade do |t|
    t.integer "categories_id"
    t.integer "sizes_id"
    t.index ["categories_id"], name: "index_categories_sizes_on_categories_id"
    t.index ["sizes_id"], name: "index_categories_sizes_on_sizes_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_solds", force: :cascade do |t|
    t.decimal "sell_price"
    t.integer "quantity"
    t.integer "product_id"
    t.integer "sale_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_solds_on_product_id"
    t.index ["sale_id"], name: "index_product_solds_on_sale_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "unit_price"
    t.datetime "entry_date"
    t.datetime "deactivation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products_categories", id: false, force: :cascade do |t|
    t.integer "products_id"
    t.integer "categories_id"
    t.index ["categories_id"], name: "index_products_categories_on_categories_id"
    t.index ["products_id"], name: "index_products_categories_on_products_id"
  end

  create_table "products_colors", id: false, force: :cascade do |t|
    t.integer "products_id"
    t.integer "colors_id"
    t.index ["colors_id"], name: "index_products_colors_on_colors_id"
    t.index ["products_id"], name: "index_products_colors_on_products_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.decimal "total_price"
    t.string "client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "salesman_id", null: false
    t.index ["salesman_id"], name: "index_sales_on_salesman_id"
  end

  create_table "size_stocks", force: :cascade do |t|
    t.integer "stock_available"
    t.integer "product_id"
    t.integer "size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_size_stocks_on_product_id"
    t.index ["size_id"], name: "index_size_stocks_on_size_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "phone"
    t.string "password"
    t.datetime "entry_date"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sales", "users", column: "salesman_id"
end
