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

ActiveRecord::Schema.define(version: 2024_06_16_052044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patients", id: :bigint, default: -> { "nextval('products_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "patient_name"
    t.string "category"
    t.text "description"
    t.string "price"
    t.string "contact_email"
    t.string "cover"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "role"
  end

  add_foreign_key "patients", "users"
end
