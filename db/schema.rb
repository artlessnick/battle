# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_22_131409) do

  create_table "gamescores", force: :cascade do |t|
    t.integer "num_game"
    t.integer "score_game", default: 0
    t.integer "count_round", default: 1
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "selected_categorys"
    t.string "selected_questions"
    t.index ["user_id"], name: "index_gamescores_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "category"
    t.string "question"
    t.string "trueanswer"
    t.string "answer1"
    t.string "answer2"
    t.string "answer3"
    t.string "answer4"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "results", force: :cascade do |t|
    t.string "category"
    t.integer "quentity_questions"
    t.integer "correct_answers", default: 0
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "round_answers", force: :cascade do |t|
    t.string "answer1"
    t.integer "question1_id"
    t.string "answer2"
    t.integer "question2_id"
    t.string "answer3"
    t.integer "question3_id"
    t.integer "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_round_answers_on_round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "num_round"
    t.integer "roundscore", default: 0
    t.integer "gamescore_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "count_questions"
    t.index ["gamescore_id"], name: "index_rounds_on_gamescore_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "allgame", default: 0
    t.integer "percent_correct_answers", default: 0
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "gamescores", "users"
  add_foreign_key "results", "users"
  add_foreign_key "round_answers", "rounds"
  add_foreign_key "rounds", "gamescores"
end
