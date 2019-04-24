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

ActiveRecord::Schema.define(version: 2019_04_24_041715) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "client_services", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.text "secret_key", null: false
    t.text "remote_public_key"
    t.string "algorithm", limit: 50, default: "HS256", null: false
    t.integer "token_timeout"
    t.datetime "expire_at"
    t.boolean "suspended", default: false, null: false
    t.integer "tag_id"
    t.text "login_redirect"
    t.text "logout_redirect"
    t.boolean "require_signed_request", default: false, null: false
    t.boolean "force_login", default: false, null: false
    t.text "login_css"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_client_services_on_tag_id"
  end

  create_table "tag_mutexes", force: :cascade do |t|
    t.integer "tag_a_id", null: false
    t.integer "tag_b_id", null: false
    t.index ["tag_a_id", "tag_b_id"], name: "idx_user_tags_mutex", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "code", null: false
    t.string "title", null: false
    t.text "description"
    t.boolean "immutable", default: false, null: false
    t.boolean "grants_admin", default: false, null: false
    t.boolean "apply_only_by_admin", default: false, null: false
    t.boolean "apply_by_default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_tags", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_user_tags_on_tag_id"
    t.index ["user_id"], name: "index_user_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", limit: 100, null: false
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.text "settings", default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

end
