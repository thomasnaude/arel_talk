# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_01_25_131357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", id: :serial, force: :cascade do |t|
    t.integer "possible_answer_id"
    t.integer "respondent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["possible_answer_id"], name: "index_answers_on_possible_answer_id"
    t.index ["respondent_id"], name: "index_answers_on_respondent_id"
  end

  create_table "possible_answers", id: :serial, force: :cascade do |t|
    t.string "label"
    t.integer "rank"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_possible_answers_on_question_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "label"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "respondents", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "possible_answers"
  add_foreign_key "answers", "respondents"
  add_foreign_key "possible_answers", "questions"
end
