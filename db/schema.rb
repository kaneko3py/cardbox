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

ActiveRecord::Schema.define(version: 20140917161939) do

  create_table "activities", force: true do |t|
    t.integer  "card_id"
    t.integer  "good_answers"
    t.integer  "total_answers"
    t.string   "reliability"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.text     "answer"
    t.integer  "count"
    t.float    "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cards", force: true do |t|
    t.integer  "user_id"
    t.integer  "no"
    t.text     "question"
    t.text     "answer"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_archive"
    t.string   "tag"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.boolean  "lock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
