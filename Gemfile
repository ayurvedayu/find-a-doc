source 'https://rubygems.org'

gem 'solidus', github: 'solidusio/solidus', branch: 'v1.1'
# Provides basic authentication functionality for testing parts of your engine
gem 'solidus_auth_devise', github: 'solidusio/solidus_auth_devise', branch: 'master'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'geocoder', '~> 1.2'
gem 'friendly_id', '~> 5.0'
gem 'slim'
gem 'slim-rails'
gem 'aws-sdk'
gem 'nested_form_fields'

group :development, :test do
  gem 'rspec-rails'
  gem 'byebug'
  gem 'rspec-autotest'
  gem 'autotest-rails'
end

group :test do
  gem 'pg'
  gem 'rspec'
  gem 'capybara'
  gem 'rspec-activemodel-mocks'
  # gem 'capybara-screenshot'
end

gemspec
