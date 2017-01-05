RSpec.shared_context 'v1 product response fields' do
  response_field :id, 'The ID number of the news item.'
  response_field :type, 'The resource type. Always <code>product</code>.'
  with_options scope: :attributes do
    response_field :title,        'The title of the product.'
    response_field :price,        'The price of the product.'
    response_field :description,  'The product description.'
  end
end

RSpec.shared_context 'v1 product show request params' do
  parameter :id, 'The ID number of the requested product.', required: true
end
