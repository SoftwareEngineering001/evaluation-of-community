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

ActiveRecord::Schema.define(version: 20181229115932) do

  create_table "attitude_to_comments", force: :cascade do |t|
    t.string   "user_id"
    t.string   "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attitude_to_comments", ["comment_id"], name: "index_attitude_to_comments_on_comment_id"
  add_index "attitude_to_comments", ["user_id", "comment_id"], name: "index_attitude_to_comments_on_user_id_and_comment_id", unique: true
  add_index "attitude_to_comments", ["user_id"], name: "index_attitude_to_comments_on_user_id"

  create_table "attitudes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "has_follow",   default: false
    t.boolean  "has_recom",    default: false
    t.boolean  "has_disrecom", default: false
    t.boolean  "has_learn",    default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "attitudes", ["course_id"], name: "index_attitudes_on_course_id"
  add_index "attitudes", ["user_id", "course_id"], name: "index_attitudes_on_user_id_and_course_id", unique: true
  add_index "attitudes", ["user_id"], name: "index_attitudes_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "difficulty"
    t.string   "homework"
    t.string   "grading"
    t.string   "gain"
    t.integer  "ratescore"
    t.integer  "upvote_count"
    t.integer  "comment_count"
    t.string   "term"
  end

  add_index "comments", ["course_id"], name: "index_comments_on_course_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "courses", force: :cascade do |t|
    t.text     "title"
    t.text     "teacher"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.decimal  "comment_counts"
    t.string   "course_major"
    t.string   "dept"
    t.string   "course_type"
    t.integer  "credit"
    t.string   "term"
    t.string   "homepage"
    t.text     "introduction"
  end

  create_table "instructions", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "instructions", ["course_id"], name: "index_instructions_on_course_id"
  add_index "instructions", ["teacher_id"], name: "index_instructions_on_teacher_id"

  create_table "interest_courses", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "interest_courses", ["course_id", "user_id"], name: "index_interest_courses_on_course_id_and_user_id", unique: true
  add_index "interest_courses", ["course_id"], name: "index_interest_courses_on_course_id"
  add_index "interest_courses", ["user_id"], name: "index_interest_courses_on_user_id"

  create_table "rates", force: :cascade do |t|
    t.float    "average_rate"
    t.string   "difficulty"
    t.string   "homework"
    t.string   "grading"
    t.string   "gain"
    t.integer  "course_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "similars", force: :cascade do |t|
    t.integer  "maincourse_id"
    t.integer  "simcourse_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "similars", ["maincourse_id", "simcourse_id"], name: "index_similars_on_maincourse_id_and_simcourse_id", unique: true
  add_index "similars", ["maincourse_id"], name: "index_similars_on_maincourse_id"
  add_index "similars", ["simcourse_id"], name: "index_similars_on_simcourse_id"

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "dept"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "homepage"
    t.string   "research"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.datetime "logout_time"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["name"], name: "index_users_on_name", unique: true

end
