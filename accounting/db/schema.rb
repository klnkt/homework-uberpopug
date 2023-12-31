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

ActiveRecord::Schema[7.0].define(version: 2023_08_18_175006) do
  create_table "accounts", force: :cascade do |t|
    t.string "public_id"
    t.string "email"
    t.string "full_name"
    t.string "position"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_id"], name: "index_accounts_on_public_id", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status", default: "New"
    t.integer "cost"
    t.integer "reward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "public_id", null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_tasks_on_account_id"
    t.index ["public_id"], name: "index_tasks_on_public_id", unique: true
  end

  add_foreign_key "tasks", "accounts"
end
