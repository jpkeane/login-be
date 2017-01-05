require 'rspec_api_documentation_helper'

RSpec.resource 'News' do
  header 'Content-Type', 'application/vnd.api+json'

  get 'api/v1/news' do
    include_context 'v1 news response fields'

    before(:each) do
      2.times do
        FactoryGirl.create(:news)
      end
    end

    example 'GET /api/v1/news' do
      explanation 'Retrieve all news items currently available.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data'].size).to eq 2
    end
  end

  get 'api/v1/news/:id' do
    include_context 'v1 news show request params'
    include_context 'v1 news response fields'

    let!(:persisted_news) { FactoryGirl.create(:news) }
    let(:id) { persisted_news.id }

    example 'GET /api/v1/news/:id' do
      explanation 'Retrieve an individual news item.'
      do_request
      expect(status).to eq 200
      response_data = JSON.parse(response_body)
      expect(response_data['data']['id']).to eq id.to_s
    end
  end
end
