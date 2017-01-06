prod1 = Product.create(title: 'Thingymajig',     price: 23.99, description: 'Get this sweet item')
prod2 = Product.create(title: 'Whatchmacallit',  price: 0.99)

5.times do
  FactoryGirl.create(:news)
end

role1 = Role.create(name: 'admin', friendly_name: 'Admin')
role2 = Role.create(name: 'customer', friendly_name: 'Customer')

user1 = User.create(username: 'admin', password: 'password', name: 'Admin Man', role: role1)
user2 = User.create(username: 'customer', password: 'password', name: 'Customer Bloke', role: role2)