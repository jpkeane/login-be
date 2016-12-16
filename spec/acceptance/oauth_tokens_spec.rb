require 'rspec_api_documentation_helper'

RSpec.resource 'OAuth Tokens' do
  post '/oauth/token' do
    include_context 'non_jsonapi_format'
    include_context 'oauth2 token password grant fields'

    let('grant_type') { 'password' }
    let('username')   { 'apitestuser' }
    let('password')   { 'apitestpassword' }
    let!(:user) { FactoryGirl.create(:user, username: username, password: password) }

    example_request 'POST /oauth/token' do
      expect(status).to eq 200
      expect(JSON.parse(response_body)['access_token']).not_to be_nil
    end
  end

  post '/oauth/revoke' do
    include_context 'authenticated'
    include_context 'non_jsonapi_format'
    include_context 'oauth2 token revoke fields'

    let(:token) { @access_token.token }
    example_request 'POST /oauth/revoke' do
      expect(status).to eq 200
    end
  end
end
