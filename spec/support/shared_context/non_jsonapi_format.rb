RSpec.shared_context 'non_jsonapi_format', non_jsonapi_format: true do
  before do
    @post_body_formatter = RspecApiDocumentation.configuration.request_body_formatter.dup
    RspecApiDocumentation.configuration.request_body_formatter = proc do |params|
      params
    end
  end

  after do
    RspecApiDocumentation.configuration.request_body_formatter = @post_body_formatter
  end
end
