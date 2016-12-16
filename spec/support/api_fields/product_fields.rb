RSpec.shared_context 'v1 products responses' do
  parameter 'id', <<-DESC, required: true
    The ID of the product.
  DESC

  parameter 'title', <<-DESC, required: true
    The title of the product.
  DESC

  parameter 'description', <<-DESC
    The description of the product.
  DESC
end
