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

ActiveRecord::Schema[8.1].define(version: 2025_11_09_144503) do
  create_table "price_entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "price_in_chf", null: false
    t.integer "ski_pass_id", null: false
    t.datetime "updated_at", null: false
    t.index ["ski_pass_id"], name: "index_price_entries_on_ski_pass_id"
  end

  create_table "ski_passes", force: :cascade do |t|
    t.string "age_group", null: false
    t.datetime "created_at", null: false
    t.virtual "month", type: :integer, as: "cast(strftime('%m', valid_on) as integer)", stored: false
    t.integer "ski_season_id", null: false
    t.datetime "updated_at", null: false
    t.date "valid_on", null: false
    t.index ["ski_season_id", "valid_on", "age_group"], name: "index_ski_passes_on_season_date_agegroup", unique: true
    t.index ["ski_season_id"], name: "index_ski_passes_on_ski_season_id"
  end

  create_table "ski_resorts", force: :cascade do |t|
    t.string "booking_url", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ski_seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date", null: false
    t.integer "ski_resort_id", null: false
    t.string "slug"
    t.date "start_date", null: false
    t.datetime "updated_at", null: false
    t.index ["ski_resort_id"], name: "index_ski_seasons_on_ski_resort_id"
    t.index ["slug"], name: "index_ski_seasons_on_slug", unique: true
  end

  add_foreign_key "price_entries", "ski_passes"
  add_foreign_key "ski_passes", "ski_seasons"
  add_foreign_key "ski_seasons", "ski_resorts"
end
