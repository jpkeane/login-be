require 'rspec_api_documentation_helper'

RSpec.resource 'OAuth Tokens' do
  post '/oauth/token' do
    include_context 'non_jsonapi_format'
    include_context 'oauth2 token password grant params'
    include_context 'oauth2 token password grant response fields'

    let('grant_type') { 'password' }
    let('username')   { 'apitestuser' }
    let('password')   { 'apitestpassword' }
    let!(:user) { FactoryGirl.create(:user, username: username, password: password) }

    example 'POST /oauth/token' do
      explanation 'Grant a new OAuth2 token for authentication with requests.'
      do_request
      expect(status).to eq 200
      expect(JSON.parse(response_body)['access_token']).not_to be_nil
    end
  end

  post '/oauth/revoke' do
    include_context 'customer authenticated request'
    include_context 'non_jsonapi_format'
    include_context 'oauth2 token revoke fields'

    let(:token) { @access_token.token }
    example 'POST /oauth/revoke' do
      explanation 'Revoke the OAuth2 token and make it unavailable for authentication.'
      do_request
      expect(status).to eq 200
    end
  end
end
