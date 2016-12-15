source 'https://rubygems.org'

ruby '2.3.3'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'

# Datastores
gem 'pg', '~> 0.18'

# Core
gem 'bcrypt', '~> 3.1.7'

# Application servers
gem 'puma', '~> 3.0'

group :development, :test do
  # Tooling
  gem 'pry-rails'
  gem 'pry-byebug'
  
  # Debugging
  gem 'byebug', platform: :mri
end

group :development do
  # Tooling
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'better_errors'
  gem 'binding_of_caller'

  # SCA
  gem 'rubocop'
  gem 'reek'
  gem 'brakeman'
end

group :test do
  # Coverage
  gem 'coveralls', require: false

  # Testing frameworks
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
end
