FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'superSafePassword123'
    password_confirmation 'superSafePassword123'

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :with_character do
      after(:create) do |instance|
        create_list :character, 1, user: instance
      end
    end
  end
end
