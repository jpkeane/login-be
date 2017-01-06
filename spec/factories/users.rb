FactoryGirl.define do
  factory :user do
    name      { Faker::Name.name }
    username  { Faker::Internet.user_name(name.to_s) }
    password  'testpassword'

    factory :admin_user do
      role { Role.find_by_name('admin') || association(:role, name: 'admin') }
    end

    factory :customer_user do
      role { Role.find_by_name('customer') || association(:role, name: 'customer') }
    end
  end
end
