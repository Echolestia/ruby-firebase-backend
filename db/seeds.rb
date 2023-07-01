# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create some users
user1 = User.create(email:"john@email.com", password: "password1 encrypted", user_type: 'admin', profile: 'url1', first_name: 'John', second_name: 'Doe', age: 30, occupation: 'Engineer', username: 'johndoe', phone_number: '1234567890', gender: 'male', pregnant: false, marital_status: 'single', pregnancy_week: nil, is_anonymous_login: false, survey_result: 'result1')
user2 = User.create(email:"user@email.com", password: "password1 encrypted", user_type: 'user', profile: 'url2', first_name: 'Jane', second_name: 'Doe', age: 25, occupation: 'Doctor', username: 'janedoe', phone_number: '0987654321', gender: 'female', pregnant: true, marital_status: 'married', pregnancy_week: 15, is_anonymous_login: false, survey_result: 'result2')
user3 = User.create(email:"test@email.com", password: "password1 encrypted", user_type: 'user', profile: 'url2', first_name: 'Jane', second_name: 'Doe', age: 25, occupation: 'Doctor', username: 'janedoe', phone_number: '0987654321', gender: 'female', pregnant: true, marital_status: 'married', pregnancy_week: 15, is_anonymous_login: false, survey_result: 'result2')

# Create some chat rooms
chat_room1 = ChatRoom.create(overall_sentiment_analysis_score: 0.85, date_created: Time.now, is_ai_chat: false, is_group_chat: false, user1_id: user1.id, user2_id: user2.id)
chat_room2 = ChatRoom.create(overall_sentiment_analysis_score: 0.95, date_created: Time.now + 1.day, is_ai_chat: true, is_group_chat: true, user1_id: user1.id, user2_id: user3.id)

# Create some messages
Message.create(sender_id: user1.id, receiver_id: user2.id, timestamp: Time.now, sentiment_analysis_score: 0.85, content: 'Hello Jane', message_type: 'text', chat_room_id: chat_room1.id)
Message.create(sender_id: user2.id, receiver_id: user1.id, timestamp: Time.now + 1.day, sentiment_analysis_score: 0.95, content: 'Hi John', message_type: 'text', chat_room_id: chat_room1.id)


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
