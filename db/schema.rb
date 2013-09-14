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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130824013027) do

  create_table "accessories", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.string   "description"
    t.decimal  "price",            :precision => 5, :scale => 2, :default => 0.0
    t.boolean  "displayable_flag",                               :default => true
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "accessories_categories", :id => false, :force => true do |t|
    t.integer "accessory_id"
    t.integer "category_id"
  end

  create_table "accounts", :force => true do |t|
    t.string   "name",         :limit => 30
    t.decimal  "balance",                    :precision => 11, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.boolean  "frozen_flag",                                               :default => false
    t.string   "account_type", :limit => 3
    t.integer  "user_id"
  end

  create_table "appointments", :force => true do |t|
    t.date     "apt_date"
    t.time     "apt_time"
    t.string   "location"
    t.string   "description"
    t.boolean  "completed_flag"
    t.boolean  "problem_flag"
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
    t.boolean  "booked_flag",                                               :default => false
    t.string   "identifier",     :limit => 6
    t.decimal  "duration",                    :precision => 3, :scale => 0
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider",   :limit => 100
    t.string   "uid",        :limit => 100
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "hairstyle_collections", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "collection_type",  :limit => 1
    t.boolean  "displayable_flag",              :default => true
  end

  create_table "hairstyle_collections_hairstyles", :id => false, :force => true do |t|
    t.integer "hairstyle_collection_id"
    t.integer "hairstyle_id"
  end

  create_table "hairstyles", :force => true do |t|
    t.string   "image"
    t.string   "name"
    t.string   "description"
    t.decimal  "price",            :precision => 5, :scale => 2, :default => 0.0
    t.boolean  "displayable_flag",                               :default => true
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "line_items", :force => true do |t|
    t.integer  "quote_box_id"
    t.integer  "quantity",      :default => 1
    t.integer  "quotable_id"
    t.string   "quotable_type"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "complete_flag"
    t.boolean  "problem_flag"
    t.text     "comments"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "quote_boxes", :force => true do |t|
    t.integer  "appointment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "order_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "user_images", :force => true do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
