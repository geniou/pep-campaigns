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

ActiveRecord::Schema.define(:version => 20130501171041) do

  create_table "admins", :force => true do |t|
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

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "answers", :force => true do |t|
    t.integer "application_id"
    t.integer "reference_id"
    t.text    "text_value"
    t.integer "question_id"
    t.decimal "numeric_value"
    t.boolean "boolean_value"
  end

  create_table "applications", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "campaign_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "campaigns", :force => true do |t|
    t.boolean  "open_to_applicants",          :default => true
    t.boolean  "open_to_referees",            :default => true
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "name",                                          :null => false
    t.text     "referee_introduction_text"
    t.integer  "required_reference_count",    :default => 10
    t.text     "applicant_introduction_text"
  end

  create_table "contacts", :force => true do |t|
    t.string   "title"
    t.string   "first_name", :null => false
    t.string   "last_name",  :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "campaign_id"
    t.string   "type",                          :null => false
    t.text     "text"
    t.string   "options"
    t.integer  "position"
    t.boolean  "required",    :default => true, :null => false
    t.string   "for",                           :null => false
  end

  create_table "references", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "campaign_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "application_id"
  end

  create_table "team_members", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
