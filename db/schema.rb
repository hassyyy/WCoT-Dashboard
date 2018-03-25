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

ActiveRecord::Schema.define(:version => 20180325033054) do

  create_table "contributions", :force => true do |t|
    t.integer  "value"
    t.string   "month"
    t.integer  "year"
    t.string   "status"
    t.string   "mode"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contributions", ["user_id", "created_at"], :name => "index_contributions_on_user_id_and_created_at"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "donations", :force => true do |t|
    t.integer  "value"
    t.integer  "resource_id"
    t.string   "bills"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "donations", ["resource_id"], :name => "index_donations_on_resource_id"

  create_table "meetings", :force => true do |t|
    t.string   "title"
    t.text     "agenda"
    t.string   "date"
    t.string   "starts_at"
    t.string   "ends_at"
    t.text     "minutes_of_meeting"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "contact_details"
    t.text     "other_details"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "user_meeting_statuses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "meeting_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_meeting_statuses", ["user_id", "meeting_id"], :name => "index_user_meeting_statuses_on_user_id_and_meeting_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "account_admin",       :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
