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

ActiveRecord::Schema[7.0].define(version: 2023_06_18_150203) do
  create_table "chat_room_users", force: :cascade do |t|
    t.integer "chat_room_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_chat_room_users_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_room_users_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.float "overall_sentiment_analysis_score"
    t.datetime "date_created"
    t.boolean "is_ai_chat"
    t.boolean "is_group_chat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.datetime "timestamp"
    t.float "sentiment_analysis_score"
    t.text "content"
    t.string "message_type"
    t.integer "chat_room_id", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chat_room_users", "chat_rooms"
  add_foreign_key "chat_room_users", "users"
  add_foreign_key "messages", "chat_rooms"
end
