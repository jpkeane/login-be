require 'rspec_api_documentation_helper'

RSpec.resource 'Products' do
  header 'Content-Type', 'application/vnd.api+json'

  get 'api/v1/products' do
    include_context 'authenticated'
    include_context 'v1 product response fields'

    before(:each) do
      2.times do
        FactoryGirl.create(:product)
      end
    end

    example 'GET /api/v1/products' do
      explanation 'Retrieve all products.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data'].size).to eq 2
    end
  end

  get 'api/v1/products/:id' do
    include_context 'authenticated'
    include_context 'v1 product show request params'
    include_context 'v1 product response fields'

    let!(:persisted_product) { FactoryGirl.create(:product) }
    let(:id) { persisted_product.id }

    example 'GET /api/v1/product/:id' do
      explanation 'Retrieve an individual product.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data']['id']).to eq id.to_s
    end
  end
end
