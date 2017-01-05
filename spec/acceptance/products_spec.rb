require 'rspec_api_documentation_helper'

RSpec.resource 'Products' do
  let(:type) { 'products' }

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

  post 'api/v1/products' do
    include_context 'authenticated'
    include_context 'v1 product create request params'

    let!(:product) { FactoryGirl.build(:product) }
    let(:title)       { product.title }
    let(:price)       { product.price }
    let(:description) { product.description }

    example 'POST /api/v1/product' do
      explanation 'Create a new product.'
      do_request
      expect(status).to eq 201
    end
  end

  patch 'api/v1/products/:id' do
    include_context 'authenticated'
    include_context 'v1 product update request params'

    let!(:product) { FactoryGirl.create(:product) }
    let(:id)          { product.id }
    let(:title)       { 'new title' }

    example 'PATCH /api/v1/product/:id' do
      explanation 'Update a specified product.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data']['attributes']['title']).to eq title
    end
  end

  delete 'api/v1/products/:id' do
    include_context 'authenticated'
    include_context 'v1 product delete request params'

    let!(:persisted_product) { FactoryGirl.create(:product) }
    let(:id) { persisted_product.id }

    example 'DELETE /api/v1/product/:id' do
      explanation 'Delete an individual product.'
      do_request
      expect(status).to eq 204
    end
  end
end
