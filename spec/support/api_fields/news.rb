RSpec.shared_context 'v1 news response fields' do
  response_field :id, 'The ID number of the news item.'
  response_field :type, 'The resource type. Always <code>news</code>.'
  with_options scope: :attributes do
    response_field :title,  'The title of the news item.'
    response_field :date,   'The date of the news item.'
    response_field :body,   'The main content of the news item.'
  end
end

RSpec.shared_context 'v1 news show request params' do
  parameter :id, 'The ID number of the requested news item.', required: true
end

RSpec.shared_context 'v1 news create request params' do
  parameter :type, 'The resource type. Always <code>news</code>.'
  with_options scope: :attributes do
    parameter :title,  'The title of the news item.', required: true
    parameter :date,   'The date of the news item.', required: true
    parameter :body,   'The main content of the news item.', required: true
  end
end
