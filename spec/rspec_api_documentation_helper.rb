require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.app = Rails.application
  config.docs_dir = Rails.root.join('doc', 'api', 'v1')
  config.format = [:json, :combined_text]
  config.filter = :all
  config.exclusion_filter = nil
  config.request_headers_to_include = %w(Content-Type Authorization)
  config.response_headers_to_include = %w(Content-Type)
  config.curl_headers_to_filter = %w(Host Cookie)
  config.keep_source_order = true
  config.api_name = 'InvoiceMe API'

  config.request_body_formatter = proc do |params|
    { data: params } if params.present?
  end
end
