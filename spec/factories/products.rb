FactoryGirl.define do
  factory :product do
    title       { Faker::Commerce.product_name }
    price       { Faker::Commerce.price }
    description { Faker::Lorem.paragraph }
  end
end
