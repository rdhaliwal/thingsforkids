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

ActiveRecord::Schema.define(version: 2018_02_13_074726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "listings", force: :cascade do |t|
    t.string "business_name"
    t.integer "min_age"
    t.integer "max_age"
    t.integer "activity_type"
    t.text "days_available", default: [], array: true
    t.text "description"
    t.string "logo"
    t.string "facbook_url"
    t.string "instagram_url"
    t.string "manager_name"
    t.string "manager_job_title"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.decimal "price"
    t.string "zip_code"
    t.string "please_bring"
    t.boolean "indoors"
    t.boolean "outdoors"
    t.boolean "parties"
    t.boolean "disability_access"
    t.boolean "parking"
    t.boolean "free_trial"
    t.boolean "undercover"
    t.boolean "bbq"
    t.boolean "toilets"
    t.boolean "highchairs"
    t.boolean "baby_change_room"
    t.datetime "opens_at"
    t.datetime "closes_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
