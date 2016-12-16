FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    username  { Faker::Internet.user_name(name.to_s) }
    password  'testpassword'
  end
end
