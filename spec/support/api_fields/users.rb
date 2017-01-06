RSpec.shared_context 'v1 user response fields' do
  response_field :id, 'The ID number of the user.'
  response_field :type, 'The resource type. Always <code>users</code>.'
  with_options scope: :attributes do
    response_field :username,   'The login username.'
    response_field :name,       'The users real name'
  end
end

RSpec.shared_context 'v1 user show request params' do
  parameter :id, 'The ID number of the requested user.', required: true
end

RSpec.shared_context 'v1 user create request params' do
  parameter :type, 'The resource type. Always <code>users</code>.', required: true
  with_options scope: :attributes do
    parameter :username,        'The login username.', required: true
    parameter :password,        'The password for login.', required: true
    parameter :name,            'The users real name.', required: true
  end
end

RSpec.shared_context 'v1 user update request params' do
  parameter :id, 'The user ID to update.', required: true
  parameter :type, 'The resource type. Always <code>users</code>.', required: true
  with_options scope: :attributes do
    parameter :password,        'The password to change to.'
    parameter :name,            'The users real name.'
  end
end
