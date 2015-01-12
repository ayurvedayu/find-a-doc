source 'https://rubygems.org'

gem 'spree', github: 'spree/spree', branch: '2-3-stable'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-3-stable'
gem 'geocoder'

group :development, :test do
  gem 'byebug'
  gem 'rspec-autotest'
  gem 'autotest-rails'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rspec-activemodel-mocks'
end

gemspec
