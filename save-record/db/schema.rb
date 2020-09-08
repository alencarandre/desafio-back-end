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

ActiveRecord::Schema.define(version: 2020_09_08_025102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movements", force: :cascade do |t|
    t.bigint "transaction_type_id", null: false
    t.datetime "transaction_date", null: false
    t.float "value", null: false
    t.string "document", null: false
    t.string "card", null: false
    t.bigint "owner_id", null: false
    t.bigint "store_id", null: false
    t.string "transaction_hash", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_movements_on_owner_id"
    t.index ["store_id"], name: "index_movements_on_store_id"
    t.index ["transaction_type_id"], name: "index_movements_on_transaction_type_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_stores_on_owner_id"
  end

  create_table "transaction_types", id: :integer, default: nil, force: :cascade do |t|
    t.string "operation", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "movements", "owners"
  add_foreign_key "movements", "stores"
  add_foreign_key "movements", "transaction_types"
  add_foreign_key "stores", "owners"
end
