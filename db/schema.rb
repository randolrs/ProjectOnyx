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

ActiveRecord::Schema.define(version: 20141122232645) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "games", force: true do |t|
    t.string   "teamh"
    t.string   "teama"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "event_time"
    t.string   "league"
    t.integer  "teama_score"
    t.integer  "teamh_score"
    t.integer  "score_spread"
    t.string   "status"
  end

  create_table "pred2s", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pred2s", ["email"], name: "index_pred2s_on_email", unique: true
  add_index "pred2s", ["reset_password_token"], name: "index_pred2s_on_reset_password_token", unique: true

  create_table "prediction_games", force: true do |t|
    t.string   "game_winner"
    t.integer  "teama_score"
    t.integer  "teamh_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.integer  "predictor_id"
    t.string   "teama"
    t.string   "teamh"
    t.string   "league"
    t.integer  "spread"
    t.string   "status"
    t.datetime "event_time"
  end

  add_index "prediction_games", ["game_id"], name: "index_prediction_games_on_game_id"
  add_index "prediction_games", ["predictor_id"], name: "index_prediction_games_on_predictor_id"

  create_table "predictions", force: true do |t|
    t.string   "event"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "category2"
    t.time     "deadline"
    t.string   "type"
    t.integer  "predictor_id"
    t.integer  "game_id"
  end

  add_index "predictions", ["game_id"], name: "index_predictions_on_game_id"

  create_table "predictors", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "predictors", ["email"], name: "index_predictors_on_email", unique: true
  add_index "predictors", ["reset_password_token"], name: "index_predictors_on_reset_password_token", unique: true

  create_table "prognosticators", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prognosticators", ["email"], name: "index_prognosticators_on_email", unique: true
  add_index "prognosticators", ["reset_password_token"], name: "index_prognosticators_on_reset_password_token", unique: true

  create_table "sports", force: true do |t|
    t.string   "subcat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "TeamA"
    t.string   "TeamB"
    t.string   "sport_id"
  end

  add_index "sports", ["sport_id"], name: "index_sports_on_sport_id"

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "league"
    t.integer  "sport_id"
  end

  add_index "teams", ["sport_id"], name: "index_teams_on_sport_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "predictor",              default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
