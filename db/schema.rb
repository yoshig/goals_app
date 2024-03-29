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

ActiveRecord::Schema.define(version: 20140301004556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cheers", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "goal_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cheers", ["goal_id"], name: "index_cheers_on_goal_id", using: :btree
  add_index "cheers", ["user_id"], name: "index_cheers_on_user_id", using: :btree

  create_table "comments", force: true do |t|
    t.string   "body",             null: false
    t.integer  "user_id",          null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "goal_comments", force: true do |t|
    t.string   "body",         null: false
    t.integer  "goal_id",      null: false
    t.integer  "submitter_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goal_comments", ["goal_id"], name: "index_goal_comments_on_goal_id", using: :btree
  add_index "goal_comments", ["submitter_id"], name: "index_goal_comments_on_submitter_id", using: :btree

  create_table "goals", force: true do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "user_id",     null: false
    t.boolean  "completed"
    t.boolean  "privacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "goals", ["title"], name: "index_goals_on_title", using: :btree
  add_index "goals", ["user_id", "completed"], name: "index_goals_on_user_id_and_completed", using: :btree
  add_index "goals", ["user_id", "privacy"], name: "index_goals_on_user_id_and_privacy", using: :btree
  add_index "goals", ["user_id"], name: "index_goals_on_user_id", using: :btree

  create_table "user_comments", force: true do |t|
    t.string   "body",         null: false
    t.integer  "user_id",      null: false
    t.integer  "submitter_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_comments", ["submitter_id"], name: "index_user_comments_on_submitter_id", using: :btree
  add_index "user_comments", ["user_id"], name: "index_user_comments_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
