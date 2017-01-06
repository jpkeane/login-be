require 'rspec_api_documentation_helper'

RSpec.resource 'User' do
  let(:type) { 'users' }

  get 'api/v1/users' do
    include_context 'admin authenticated request'
    include_context 'v1 user response fields'

    before(:each) do
      3.times do
        FactoryGirl.create(:customer_user)
      end
    end

    example 'GET /api/v1/users' do
      explanation 'Retrieve all users.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      # 3 created plus the admin user
      expect(response_data['data'].size).to eq 4
    end
  end

  get 'api/v1/users/:id' do
    include_context 'admin authenticated request'
    include_context 'v1 user show request params'
    include_context 'v1 user response fields'

    let!(:persisted_user) { FactoryGirl.create(:user) }
    let(:id) { persisted_user.id }

    example 'GET /api/v1/users/:id' do
      explanation 'Show the requested user'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data']['id']).to eq id.to_s
    end
  end

  post 'api/v1/users' do
    include_context 'v1 user create request params'

    let!(:user)       { FactoryGirl.build(:user) }
    let(:username)    { user.username }
    let(:name)        { user.name }
    let(:password)    { user.password }

    example 'POST /api/v1/users' do
      explanation 'Create a new user.'
      do_request
      expect(status).to eq 201
    end
  end

  patch 'api/v1/users/:id' do
    include_context 'admin authenticated request'
    include_context 'v1 user update request params'

    let!(:user) { FactoryGirl.create(:user) }
    let(:id)    { user.id }
    let(:name)  { 'TEST' }

    example 'PATCH /api/v1/user/:id' do
      explanation 'Update a user.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data']['attributes']['name']).to eq name
    end
  end
end
