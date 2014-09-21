FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password 'superSafePassword123'
    password_confirmation 'superSafePassword123'

    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end
