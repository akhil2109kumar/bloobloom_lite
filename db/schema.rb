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

ActiveRecord::Schema[7.0].define(version: 2024_04_23_053014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "frames", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.integer "stock", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "glasses", force: :cascade do |t|
    t.bigint "frame_id", null: false
    t.bigint "shopping_basket_id", null: false
    t.integer "lens_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["frame_id"], name: "index_glasses_on_frame_id"
    t.index ["shopping_basket_id"], name: "index_glasses_on_shopping_basket_id"
  end

  create_table "lenses", force: :cascade do |t|
    t.text "description"
    t.integer "prescription_type"
    t.integer "lens_type"
    t.string "colour"
    t.integer "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prices", force: :cascade do |t|
    t.string "priceable_type", null: false
    t.bigint "priceable_id", null: false
    t.decimal "amount", null: false
    t.string "currency", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priceable_type", "priceable_id", "currency"], name: "index_prices_on_priceable_type_and_priceable_id_and_currency", unique: true
    t.index ["priceable_type", "priceable_id"], name: "index_prices_on_priceable"
  end

  create_table "shopping_baskets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_baskets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "glasses", "frames"
  add_foreign_key "glasses", "lenses", column: "lens_id"
  add_foreign_key "glasses", "shopping_baskets"
  add_foreign_key "shopping_baskets", "users"
end
