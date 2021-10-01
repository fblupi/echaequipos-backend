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

ActiveRecord::Schema.define(version: 2018_11_20_153920) do

  create_table "affiliations", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.integer "affiliation_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_affiliations_on_group_id"
    t.index ["user_id"], name: "index_affiliations_on_user_id"
  end

  create_table "affiliations_positions", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "affiliation_id", null: false
    t.bigint "position_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "affiliation_id", null: false
    t.string "name", null: false
    t.datetime "date", null: false
    t.integer "duration", null: false
    t.integer "status", null: false
    t.integer "min_players", null: false
    t.integer "max_players", null: false
    t.string "location", null: false
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliation_id"], name: "index_matches_on_affiliation_id"
    t.index ["group_id"], name: "index_matches_on_group_id"
  end

  create_table "players", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "affiliation_id", null: false
    t.boolean "attendance", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliation_id"], name: "index_players_on_affiliation_id"
    t.index ["match_id"], name: "index_players_on_match_id"
  end

  create_table "positions", charset: "utf8mb4", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_es", null: false
    t.string "abbr_en", null: false
    t.string "abbr_es", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "phone_number"
    t.date "birth_date"
    t.boolean "admin", default: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "jti", null: false
    t.string "device_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
