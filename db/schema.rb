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

ActiveRecord::Schema.define(version: 20160324093614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.text     "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "title"
  end

  add_index "books", ["slug"], name: "index_books_on_slug", unique: true, using: :btree

  create_table "persisted_events", force: :cascade do |t|
    t.string   "event_type",         null: false
    t.string   "visitor_identifier"
    t.json     "payload"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "persisted_events", ["visitor_identifier"], name: "index_persisted_events_on_visitor_identifier", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.string   "currency"
    t.integer  "price_in_cents"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "products", ["purchasable_type", "purchasable_id"], name: "index_products_on_purchasable_type_and_purchasable_id", using: :btree

end
