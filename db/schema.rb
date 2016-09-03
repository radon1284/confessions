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

ActiveRecord::Schema.define(version: 20160903084027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.string   "short_description"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "main_image"
    t.boolean  "published",         default: false, null: false
  end

  create_table "books", force: :cascade do |t|
    t.text     "slug"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.text     "title"
    t.text     "content_pdf"
    t.text     "content_epub"
    t.text     "content_mobi"
    t.text     "content_pdf_preview"
    t.index ["slug"], name: "index_books_on_slug", unique: true, using: :btree
  end

  create_table "chapters", force: :cascade do |t|
    t.integer  "book_id",      null: false
    t.integer  "number",       null: false
    t.text     "content_html", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "title"
    t.text     "slug"
    t.index ["book_id", "number"], name: "index_chapters_on_book_id_and_number", unique: true, using: :btree
    t.index ["book_id"], name: "index_chapters_on_book_id", using: :btree
  end

  create_table "customer_support_requests", force: :cascade do |t|
    t.text     "subject"
    t.text     "body"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_requests", force: :cascade do |t|
    t.uuid     "order_id"
    t.text     "company_name"
    t.text     "address"
    t.text     "country"
    t.text     "vat_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["order_id"], name: "index_invoice_requests_on_order_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.uuid     "order_id"
    t.integer  "price_in_cents"
    t.string   "currency"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
    t.index ["product_id"], name: "index_order_items_on_product_id", using: :btree
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.text     "invoice_number"
    t.inet     "ip_address"
    t.index ["invoice_number"], name: "index_orders_on_invoice_number", unique: true, using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "persisted_events", force: :cascade do |t|
    t.string   "event_type",         null: false
    t.string   "visitor_identifier"
    t.json     "payload"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["visitor_identifier"], name: "index_persisted_events_on_visitor_identifier", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "purchasable_id"
    t.string   "purchasable_type"
    t.string   "currency"
    t.integer  "price_in_cents"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["purchasable_type", "purchasable_id"], name: "index_products_on_purchasable_type_and_purchasable_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_taggings_on_article_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                      null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "subscribed_to_mailing_list", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "watermarked_books", force: :cascade do |t|
    t.uuid     "order_id"
    t.integer  "book_id"
    t.text     "content_pdf"
    t.text     "content_epub"
    t.text     "content_mobi"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["book_id"], name: "index_watermarked_books_on_book_id", using: :btree
    t.index ["order_id"], name: "index_watermarked_books_on_order_id", using: :btree
  end

  add_foreign_key "chapters", "books"
  add_foreign_key "invoice_requests", "orders"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "taggings", "articles"
  add_foreign_key "taggings", "tags"
  add_foreign_key "watermarked_books", "books"
  add_foreign_key "watermarked_books", "orders"
end
