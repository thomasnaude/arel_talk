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

ActiveRecord::Schema.define(version: 20180125131357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer  "possible_answer_id"
    t.integer  "respondent_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["possible_answer_id"], name: "index_answers_on_possible_answer_id", using: :btree
    t.index ["respondent_id"], name: "index_answers_on_respondent_id", using: :btree
  end

  create_table "possible_answers", force: :cascade do |t|
    t.string   "label"
    t.integer  "rank"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_possible_answers_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "label"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "respondents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "possible_answers"
  add_foreign_key "answers", "respondents"
  add_foreign_key "possible_answers", "questions"
end
