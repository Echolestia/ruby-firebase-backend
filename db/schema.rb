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

ActiveRecord::Schema[7.0].define(version: 2023_07_08_173642) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.datetime "published_date"
    t.datetime "created_date"
    t.string "title"
    t.string "author"
    t.string "img_url"
    t.string "url"
    t.text "user_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.float "overall_sentiment_analysis_score"
    t.datetime "date_created"
    t.boolean "is_ai_chat"
    t.boolean "is_group_chat"
    t.bigint "user1_id"
    t.bigint "user2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user1_id"], name: "index_chat_rooms_on_user1_id"
    t.index ["user2_id"], name: "index_chat_rooms_on_user2_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "timestamp"
    t.float "sentiment_analysis_score"
    t.text "content"
    t.string "message_type"
    t.bigint "chat_room_id", null: false
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_type"
    t.string "profile"
    t.string "first_name"
    t.string "second_name"
    t.integer "age"
    t.string "occupation"
    t.string "username"
    t.string "phone_number"
    t.string "gender"
    t.boolean "pregnant"
    t.string "marital_status"
    t.integer "pregnancy_week"
    t.boolean "is_anonymous_login"
    t.string "survey_result"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "chat_rooms", "users", column: "user1_id"
  add_foreign_key "chat_rooms", "users", column: "user2_id"
  add_foreign_key "messages", "chat_rooms"
end
