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

ActiveRecord::Schema.define(version: 20180212103516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "main_products", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "shop_name", null: false
    t.string "subdomain", null: false
    t.string "domain"
    t.bigint "theme_id"
    t.bigint "main_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["main_product_id"], name: "index_shops_on_main_product_id"
    t.index ["subdomain"], name: "index_shops_on_subdomain", unique: true
    t.index ["theme_id"], name: "index_shops_on_theme_id"
  end

  create_table "site_admins", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "contact_number", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_site_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_site_admins_on_reset_password_token", unique: true
  end

  create_table "themes", force: :cascade do |t|
    t.string "theme_name"
    t.text "description"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "shops", "main_products"
  add_foreign_key "shops", "themes"
end
