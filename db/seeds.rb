# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create some users
user1 = User.create(user_type: 'admin', profile: 'profile1', first_name: 'John', second_name: 'Doe', age: 30, occupation: 'Engineer', username: 'johndoe', phone_number: '1234567890')
user2 = User.create(user_type: 'client', profile: 'profile2', first_name: 'Jane', second_name: 'Doe', age: 25, occupation: 'Designer', username: 'janedoe', phone_number: '0987654321')

# Create some chat rooms
chat_room1 = ChatRoom.create(overall_sentiment_analysis_score: 0.8, date_created: Time.now, is_ai_chat: false, is_group_chat: false)
chat_room2 = ChatRoom.create(overall_sentiment_analysis_score: 0.7, date_created: Time.now, is_ai_chat: true, is_group_chat: true)

# Add users to chat rooms
ChatRoomUser.create(chat_room: chat_room1, user: user1)
ChatRoomUser.create(chat_room: chat_room2, user: user2)

# Create some messages
Message.create(sender_id: user1.id, receiver_id: user2.id, timestamp: Time.now, sentiment_analysis_score: 0.9, content: 'Hello, how are you?', message_type: 'text', chat_room: chat_room1)
Message.create(sender_id: user2.id, receiver_id: user1.id, timestamp: Time.now, sentiment_analysis_score: 0.8, content: 'I am fine, thank you!', message_type: 'text', chat_room: chat_room2)
