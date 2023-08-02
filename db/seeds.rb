# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb
require 'faker'

# Create some users
# users = 50.times.map do |i|
#   User.create(
#     email: "user#{i}@email.com", 
#     password: "password#{i}", 
#     user_type: i.zero? ? 'admin' : 'user', 
#     profile: "https://picsum.photos/200", 
#     first_name: "User#{i}", 
#     second_name: "Last#{i}", 
#     age: 20+i, 
#     occupation: 'Occupation', 
#     username: "user#{i}", 
#     phone_number: '1234567890', 
#     gender: i.even? ? 'male' : 'female', 
#     pregnant: false, 
#     marital_status: 'single', 
#     pregnancy_week: nil, 
#     is_anonymous_login: false, 
#     survey_result: 'result1'
#   )
# end
users = 50.times.map do |i|
  User.create(
    email: Faker::Internet.email,
    password: "password#{i}", 
    user_type: i.zero? ? 'admin' : 'user', 
    profile: Faker::Avatar.image,
    first_name: Faker::Name.first_name, 
    second_name: Faker::Name.last_name, 
    age: Faker::Number.between(from: 20, to: 60), 
    occupation: Faker::Job.title,
    username: Faker::Internet.username, 
    phone_number: Faker::PhoneNumber.phone_number, 
    gender: i.even? ? 'male' : 'female', 
    pregnant: false, 
    marital_status: 'single', 
    pregnancy_week: nil, 
    is_anonymous_login: false, 
    survey_result: 'result1'
  )
end


# Create more chat rooms
chat_rooms = 50.times.map do |i|
  user1_id = 1
  user2_id = users[(i+1)%10].id  # To ensure the second user id is always different from the first, and within the range

  ChatRoom.create(
    overall_sentiment_analysis_score: 0.85, 
    date_created: Time.now + i.days, 
    is_ai_chat: false, 
    is_group_chat: false, 
    user1_id: user1_id, 
    user2_id: user2_id
  )
end

# Create more messages
100.times do |i|
  sender_id = users[i%10].id
  receiver_id = users[(i+1)%10].id  # To ensure the receiver id is always different from the sender, and within the range
  chat_room_id = chat_rooms[i%10].id

  Message.create(
    sender_id: sender_id, 
    receiver_id: 1, 
    timestamp: Time.now + i.hours, 
    sentiment_analysis_score: 0.85, 
    content: "Message #{i}", 
    message_type: 'text', 
    chat_room_id: chat_room_id,
    read: i.even? # This will create a mix of read and unread messages
  )
end
100.times do |i|
  sender_id = users[i%10].id
  receiver_id = users[(i+1)%10].id  # To ensure the receiver id is always different from the sender, and within the range
  chat_room_id = chat_rooms[i%10].id

  Message.create(
    sender_id: 1, 
    receiver_id: receiver_id, 
    timestamp: Time.now + i.hours, 
    sentiment_analysis_score: 0.85, 
    content: "Message #{i}", 
    message_type: 'text', 
    chat_room_id: chat_room_id,
    read: i.even? # This will create a mix of read and unread messages
  )
end


# article1 = Article.create(published_date: "2015-02-19T00:00:00Z", created_date: "2023-06-15T00:00:00Z", 
# title: "5 Things to Do After a Surprise Pregnancy", 
# author: "Camille Noe Pagán", 
# img_url: "https://hips.hearstapps.com/hmg-prod/images/cute-cat-photos-1593441022.jpg?crop=1.00xw:0.753xh;0,0.153xh&resize=1200:*",
# url: "https://www.purina.ca/articles/cat/behaviour/how-do-cats-be-petted#:~:text=In%20general%2C%20cats%20prefer%20to,super%20sensitive)%20are%20best%20avoided.")
# db/seeds.rb

# Create some articles
article1 = Article.create(
  published_date: "2015-02-19T00:00:00Z",
  created_date: "2023-06-15T00:00:00Z",
  title: "5 Things to Do After a Surprise Pregnancy",
  author: "Camille Noe Pagán",
  img_url: "https://img.wbmdstatic.com/vim/live/webmd/consumer_assets/site_images/article_thumbnails/reference_guide/warning_signs_premature_labor_ref_guide/110x70_warning_signs_premature_labor_ref_guide.jpg?resize=110px:*&amp;output-quality=50",
  url: "https://www.webmd.com/baby/features/5-things-to-do-after-a-surprise-pregnancy",
  user_group: ["Pregnant Teens", "Pregnant Adults"]
)

article2 = Article.create(
  published_date: "2015-02-19T00:00:00Z",
  created_date: "2023-06-15T00:00:00Z",
  title: "New guidelines to support mental health of women during pregnancy and after birth",
  author: "Joyce Teo",
  img_url: "https://static1.straitstimes.com.sg/s3fs-public/styles/large30x20/public/articles/2023/02/18/iStock-1143643819.jpg?VersionId=zT02Jf2ex3pFgtRombKVpgOAqXTfC0pq&itok=Y42gaxPw",
  url: "https://www.straitstimes.com/singapore/health/new-guidelines-to-support-mental-health-of-women-during-pregnancy-and-after-birth",
  user_group: ["Pregnant Teens", "Pregnant Adults"]
)
article3 = Article.create(
  published_date: "2022-04-01T00:00:00Z",
  created_date: "2023-06-15T00:00:00Z",
  title: "Pregnant and unwed at 19, her parents kicked her out after she refused abortion",
  author: "Theresa Tan",
  img_url: "https://static1.straitstimes.com.sg/s3fs-public/styles/large30x20/public/articles/2022/04/01/ads-bellyt-01042022.jpg?VersionId=mLbC.4dbeOWUdDc5Ac9aEK6.aFda3t15&itok=vC-dF69G",
  url: "https://www.straitstimes.com/singapore/community/pregnant-and-unwed-at-19-her-parents-kicked-her-out-after-she-refused-abortion",
  user_group: ["Pregnant Teens", "Pregnant Adults"]
)
