FactoryGirl.define do
  factory :character do
    name { Faker::Name.first_name }
    user
  end
end
