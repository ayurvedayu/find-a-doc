source 'https://rubygems.org'

gem 'spree', github: 'spree/spree', branch: '2-3-stable'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-3-stable'
gem 'bootstrap-sass', '~> 3.3.3'
gem 'geocoder', '~> 1.2'
gem 'friendly_id', '~> 5.0'
gem 'phony_rails'
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
