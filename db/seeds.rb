prod1 = Product.create(title: 'Thingymajig',     price: 23.99, description: 'Get this sweet item')
prod2 = Product.create(title: 'Whatchmacallit',  price: 0.99)

5.times do
  FactoryGirl.create(:news)
end