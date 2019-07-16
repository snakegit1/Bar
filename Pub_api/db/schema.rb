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

ActiveRecord::Schema.define(version: 20190518220553) do

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "token",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "drink_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "enable",                  default: true
  end

  create_table "drinks", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "description",        limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "drink_category_id",  limit: 4
    t.boolean  "enable",                         default: true
  end

  add_index "drinks", ["drink_category_id"], name: "index_drinks_on_drink_category_id", using: :btree

  create_table "gifts", force: :cascade do |t|
    t.integer "user_id",   limit: 4
    t.integer "drink_id",  limit: 4
    t.integer "pub_id",    limit: 4
    t.string  "gift_name", limit: 255
    t.integer "status",    limit: 4,   default: 0
  end

  add_index "gifts", ["drink_id"], name: "index_gifts_on_drink_id", using: :btree
  add_index "gifts", ["pub_id"], name: "index_gifts_on_pub_id", using: :btree
  add_index "gifts", ["user_id"], name: "index_gifts_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "pub_id",         limit: 4
    t.float    "price",          limit: 24
    t.boolean  "status",                     default: false
    t.string   "ip",             limit: 255
    t.string   "payment_method", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "token",          limit: 255
  end

  create_table "orders_drinks", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "drink_id",   limit: 4
    t.float    "price",      limit: 24
    t.float    "quantity",   limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "pub_drinks", force: :cascade do |t|
    t.integer  "price",       limit: 4
    t.string   "description", limit: 255
    t.integer  "drink_id",    limit: 4
    t.integer  "pub_id",      limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "enable",                  default: true
  end

  create_table "pubs", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "description",             limit: 255
    t.string   "telephone1",              limit: 255
    t.string   "telephone2",              limit: 255
    t.string   "location",                limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "image_logo_file_name",    limit: 255
    t.string   "image_logo_content_type", limit: 255
    t.integer  "image_logo_file_size",    limit: 4
    t.datetime "image_logo_updated_at"
    t.integer  "user_id",                 limit: 4
    t.string   "bank_name",               limit: 255
    t.string   "bank_account_type",       limit: 255
    t.string   "bank_account_number",     limit: 255
    t.string   "bank_account_rut",        limit: 255
    t.string   "bank_account_email",      limit: 255
    t.integer  "order_index",             limit: 4
    t.boolean  "enable",                              default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,   default: "email", null: false
    t.string   "uid",                    limit: 255,   default: "",      null: false
    t.string   "encrypted_password",     limit: 255,   default: "",      null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                default: false
    t.boolean  "super_admin",                          default: false
    t.string   "lastname",               limit: 255
    t.string   "braintree_customer_id",  limit: 256
    t.date     "born_date"
    t.string   "genre",                  limit: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
