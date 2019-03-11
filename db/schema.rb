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

ActiveRecord::Schema.define(version: 2019_03_11_230958) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "netflix_titles", force: :cascade do |t|
    t.string "wikidata_id"
    t.string "name"
    t.text "description"
    t.text "aliases"
    t.string "fb_id"
    t.string "imdb_id"
    t.string "nf_id"
    t.string "wiki_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["description"], name: "index_netflix_titles_on_description"
    t.index ["fb_id"], name: "index_netflix_titles_on_fb_id"
    t.index ["imdb_id"], name: "index_netflix_titles_on_imdb_id"
    t.index ["name"], name: "index_netflix_titles_on_name"
    t.index ["nf_id"], name: "index_netflix_titles_on_nf_id"
    t.index ["wiki_title"], name: "index_netflix_titles_on_wiki_title"
    t.index ["wikidata_id"], name: "index_netflix_titles_on_wikidata_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "watched_entries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "netflix_title_id"
    t.datetime "watched_at"
    t.text "history_entry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["history_entry"], name: "index_watched_entries_on_history_entry"
    t.index ["netflix_title_id"], name: "index_watched_entries_on_netflix_title_id"
    t.index ["user_id"], name: "index_watched_entries_on_user_id"
  end

  add_foreign_key "watched_entries", "netflix_titles"
  add_foreign_key "watched_entries", "users"
end
