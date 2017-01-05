RSpec.shared_context 'oauth2 token password grant params' do
  parameter 'grant_type', 'OAuth Grant Type. Must be <code>password</code>', required: true
  parameter 'username', 'Username to login with', required: true
  parameter 'password', 'Password to login with', required: true
end

RSpec.shared_context 'oauth2 token password grant response fields' do
  response_field 'access_token', 'OAuth bearer access token'
  response_field 'token_type', 'OAuth token type. Will be <code>bearer</code>'
  response_field 'created_at', 'Token created timestamp'
end

RSpec.shared_context 'oauth2 token revoke fields' do
  parameter 'token', 'OAuth token to be revoked. Must be owned by the account authorizing.', required: true
end
