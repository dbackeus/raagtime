# encoding: UTF-8
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

ActiveRecord::Schema[6.1].define(version: 20201030110219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clips", force: :cascade do |t|
    t.integer  "raga_id"
    t.string   "title",         null: false
    t.string   "url",           null: false
    t.string   "embed_code"
    t.string   "thumbnail_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "clips", ["raga_id"], name: "index_clips_on_raga_id", using: :btree

  create_table "ragas", force: :cascade do |t|
    t.string   "title",                            null: false
    t.string   "ascending_scale",                  null: false
    t.string   "descending_scale",                 null: false
    t.string   "thaat"
    t.string   "pakad"
    t.string   "drone"
    t.string   "samvaadi"
    t.string   "vaadi"
    t.string   "time"
    t.string   "chakra"
    t.string   "spotify_playlist_url"
    t.string   "description"
    t.string   "slug",                             null: false
    t.integer  "clips_count",          default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "ragas", ["slug"], name: "index_ragas_on_slug", unique: true, using: :btree
  add_index "ragas", ["title"], name: "index_ragas_on_title", unique: true, using: :btree

  add_foreign_key "clips", "ragas"
end
