require 'rspec_api_documentation_helper'

RSpec.resource 'Products' do
  get 'api/v1/products' do
    include_context 'authenticated'
    include_context 'v1 products responses'

    before do
      Product.create(title: 'test', price: 23.45)
      Product.create(title: 'test', price: 23.45)
    end

    example_request 'GET /api/v1/accounts' do
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data.size).to eq 2
    end
  end
end
