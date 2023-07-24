# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Alphanumeric.alphanumeric(number: 10) }
      user_type { "admin" }
      profile { "test profile" }
      first_name { "John" }
      second_name { "Doe" }
      age { 30 }
      occupation { "Engineer" }
      username { "johndoe" }
      phone_number { "1234567890" }
      gender { "male" }
      pregnant { false }
      marital_status { "single" }
      pregnancy_week { 0 }
      is_anonymous_login { false }
      survey_result { "test" }
      # add other attributes here
    end
  end
  