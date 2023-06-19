# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create some users
user1 = User.create(user_type: 'admin', profile: 'url1', first_name: 'John', second_name: 'Doe', age: 30, occupation: 'Engineer', username: 'johndoe', phone_number: '1234567890', gender: 'male', pregnant: false, marital_status: 'single', pregnancy_week: nil, is_anonymous_login: false, survey_result: 'result1')
user2 = User.create(user_type: 'user', profile: 'url2', first_name: 'Jane', second_name: 'Doe', age: 25, occupation: 'Doctor', username: 'janedoe', phone_number: '0987654321', gender: 'female', pregnant: true, marital_status: 'married', pregnancy_week: 15, is_anonymous_login: false, survey_result: 'result2')

# Create some chat rooms
chat_room1 = ChatRoom.create(overall_sentiment_analysis_score: 0.85, date_created: Time.now, is_ai_chat: false, is_group_chat: false)
chat_room2 = ChatRoom.create(overall_sentiment_analysis_score: 0.95, date_created: Time.now + 1.day, is_ai_chat: true, is_group_chat: true)

# Assign users to chat rooms
ChatRoomUser.create(chat_room_id: chat_room1.id, user_id: user1.id)
ChatRoomUser.create(chat_room_id: chat_room1.id, user_id: user2.id)
ChatRoomUser.create(chat_room_id: chat_room2.id, user_id: user1.id)

# Create some messages
Message.create(sender_id: user1.id, receiver_id: user2.id, timestamp: Time.now, sentiment_analysis_score: 0.85, content: 'Hello Jane', message_type: 'text', chat_room_id: chat_room1.id)
Message.create(sender_id: user2.id, receiver_id: user1.id, timestamp: Time.now + 1.day, sentiment_analysis_score: 0.95, content: 'Hi John', message_type: 'text', chat_room_id: chat_room1.id)

# Create some graph points
GraphPoint.create(x: 0.1, y: 0.85, chat_room_id: chat_room1.id)
GraphPoint.create(x: 0.2, y: 0.95, chat_room_id: chat_room1.id)


article1 = Article.create(published_date: "2015-02-19T00:00:00Z", created_date: "2023-06-15T00:00:00Z", title: "5 Things to Do After a Surprise Pregnancy", author: "Camille Noe Pagán", img_url: "https://cdn.pixabay.com/photo/2015/09/21/14/24/zombie-949916_960_720.jpg", url: "https://www.webmd.com/baby/features/5-things-to-do-after-a-surprise-pregnancy")
# db/seeds.rb

# Create some articles
article1 = Article.create(
  published_date: "2015-02-19T00:00:00Z",
  created_date: "2023-06-15T00:00:00Z",
  title: "5 Things to Do After a Surprise Pregnancy",
  author: "Camille Noe Pagán",
  img_url: "https://cdn.pixabay.com/photo/2015/09/21/14/24/zombie-949916_960_720.jpg",
  url: "https://www.webmd.com/baby/features/5-things-to-do-after-a-surprise-pregnancy",
  user_group: ["group1", "group2"]
)
