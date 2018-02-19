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

ActiveRecord::Schema.define(version: 20180218154940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "skus", force: :cascade do |t|
    t.string "sku_code", null: false
    t.string "supplier_code", null: false
    t.string "additional_field1"
    t.string "additional_field2"
    t.string "additional_field3"
    t.string "additional_field4"
    t.string "additional_field5"
    t.string "additional_field6"
    t.decimal "price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sku_code"], name: "index_skus_on_sku_code", unique: true
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", null: false
    t.string "supplier_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_code"], name: "index_suppliers_on_supplier_code", unique: true
  end

end
