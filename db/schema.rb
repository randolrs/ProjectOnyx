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

ActiveRecord::Schema.define(version: 20160122025707) do

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

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.integer  "hits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "predictor_id"
    t.string   "event_type"
    t.integer  "event_id"
    t.datetime "event_time"
    t.string   "teama"
    t.string   "teamh"
  end

  create_table "charges", force: true do |t|
    t.integer  "user_id"
    t.integer  "predictor_id"
    t.decimal  "amount",       precision: 8, scale: 0, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptions", force: true do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "game_winner"
    t.integer  "teama_id"
    t.integer  "teamh_id"
    t.string   "event_city"
    t.string   "event_venue"
    t.string   "season",       default: ""
  end

  create_table "plans", force: true do |t|
    t.string   "stripe_id",                                default: ""
    t.string   "description",                              default: ""
    t.decimal  "cost",             precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "credit_per_month", precision: 8, scale: 2, default: 0.0
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

  create_table "prediction_economics", force: true do |t|
    t.string   "type"
    t.string   "country"
    t.datetime "strike_date"
    t.string   "strike_date_descriptor"
    t.decimal  "value",                  precision: 10, scale: 6, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prediction_economies", force: true do |t|
    t.string   "type"
    t.integer  "type_id"
    t.datetime "strike_date"
    t.string   "strike_description"
    t.string   "country"
    t.decimal  "value",              precision: 10, scale: 6, default: 0.0
    t.integer  "integer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "teama_tscore"
    t.integer  "teamh_tscore"
    t.integer  "spreadt"
    t.string   "game_winnert"
    t.time     "timetoevent"
    t.integer  "teamh_diff"
    t.integer  "teama_diff"
    t.integer  "spread_diff"
    t.boolean  "game_winner_yesno"
    t.integer  "article_id"
    t.boolean  "paid"
    t.float    "price"
    t.decimal  "cost",              precision: 8, scale: 2
    t.float    "onyx"
    t.float    "ou_diff"
    t.string   "title",                                     default: ""
    t.text     "body",                                      default: ""
    t.integer  "overunder",                                 default: 0
  end

  add_index "prediction_games", ["game_id"], name: "index_prediction_games_on_game_id"
  add_index "prediction_games", ["predictor_id"], name: "index_prediction_games_on_predictor_id"

  create_table "prediction_games_users", id: false, force: true do |t|
    t.string  "user_id"
    t.integer "prediction_game_id"
    t.time    "purchasetime"
  end

  add_index "prediction_games_users", ["prediction_game_id"], name: "index_prediction_games_users_on_prediction_game_id"
  add_index "prediction_games_users", ["user_id"], name: "index_prediction_games_users_on_user_id"

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
    t.string   "email",                                                      default: "",    null: false
    t.string   "encrypted_password",                                         default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "username"
    t.decimal  "balance",                                                    default: 0.0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "bio",                    limit: 250
    t.boolean  "account",                                                    default: false
    t.string   "account_id"
    t.string   "stripe_account_id"
    t.string   "account_token"
    t.string   "account_key_secret"
    t.string   "subscription_id"
    t.float    "rating",                                                     default: 0.0
    t.decimal  "subscription_price",                                         default: 5.0
    t.integer  "subscription_count"
    t.string   "type",                                                       default: ""
    t.decimal  "credit_balance",                     precision: 8, scale: 2, default: 0.0
  end

  add_index "predictors", ["email"], name: "index_predictors_on_email", unique: true
  add_index "predictors", ["reset_password_token"], name: "index_predictors_on_reset_password_token", unique: true

  create_table "predictors_users", id: false, force: true do |t|
    t.integer "predictor_id"
    t.integer "user_id"
    t.boolean "premium"
  end

  create_table "predictors_users_join", id: false, force: true do |t|
    t.integer "predictor_id"
    t.integer "user_id"
  end

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

  create_table "purchases", force: true do |t|
    t.integer  "user_id"
    t.integer  "predictor_id"
    t.string   "plan_id"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "premium"
    t.decimal  "price",        precision: 8, scale: 0, default: 0
    t.datetime "next_payment"
    t.boolean  "active"
  end

  create_table "sports", force: true do |t|
    t.string   "subcat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "TeamA"
    t.string   "TeamB"
    t.string   "sport_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "banner_image_file_name"
    t.string   "banner_image_content_type"
    t.integer  "banner_image_file_size"
    t.datetime "banner_image_updated_at"
    t.string   "current_season",            default: ""
  end

  add_index "sports", ["sport_id"], name: "index_sports_on_sport_id"

  create_table "subscriptions", force: true do |t|
    t.string   "stripe_id",                           default: ""
    t.string   "string",                              default: ""
    t.string   "description",                         default: ""
    t.decimal  "cost",        precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "league"
    t.integer  "sport_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "sub_name"
    t.string   "sub_category",       default: ""
    t.string   "full_name",          default: ""
  end

  add_index "teams", ["sport_id"], name: "index_teams_on_sport_id"

  create_table "user_prediction_games", id: false, force: true do |t|
    t.string  "user_id"
    t.integer "prediction_game_id"
  end

  add_index "user_prediction_games", ["prediction_game_id"], name: "index_user_prediction_games_on_prediction_game_id"
  add_index "user_prediction_games", ["user_id"], name: "index_user_prediction_games_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                                          default: "",    null: false
    t.string   "encrypted_password",                             default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                  default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "predictor",                                      default: false
    t.decimal  "balance",                precision: 8, scale: 2, default: 0.0
    t.string   "name"
    t.string   "username"
    t.string   "account_id"
    t.string   "account_key_p"
    t.string   "account_key_s"
    t.string   "customer_id"
    t.string   "default_source"
    t.decimal  "credit_balance",         precision: 8, scale: 2, default: 0.0
    t.string   "subscription_id",                                default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
