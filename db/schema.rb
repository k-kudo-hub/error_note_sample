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

ActiveRecord::Schema.define(version: 2021_04_30_113609) do

  create_table "languages", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "log_languages", charset: "utf8", force: :cascade do |t|
    t.bigint "log_id"
    t.bigint "language_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["language_id"], name: "index_log_languages_on_language_id"
    t.index ["log_id"], name: "index_log_languages_on_log_id"
  end

  create_table "logs", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "error", null: false
    t.text "solution"
    t.boolean "release"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title", null: false
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "stocks", charset: "utf8", force: :cascade do |t|
    t.bigint "log_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["log_id"], name: "index_stocks_on_log_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "introduce"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "log_languages", "languages"
  add_foreign_key "log_languages", "logs"
  add_foreign_key "logs", "users"
  add_foreign_key "stocks", "logs"
  add_foreign_key "stocks", "users"
end
