FactoryGirl.define do
  factory :role do
    sequence(:name) { |n| "role-#{n}" }
    sequence(:friendly_name) { |n| "Role #{n}" }
  end
end
