FactoryGirl.define do
  factory :news do
    title   { Faker::Lorem.sentence }
    date    { Faker::Date.between(30.days.ago, Time.zone.today) }
    body    { Faker::Lorem.paragraphs(1) }
  end
end
