SpreeFindaDoc
===============

Introduction goes here.

Installation
------------

Add spree_finda_doc and haml to your Gemfile:

```ruby
gem 'haml'
gem 'spree_finda_doc'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_finda_doc:install
```

Also add the jquery.ui javascript.

Also specify mailer in devise.rb

```ruby
Devise.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in DeviseMailer.
  config.mailer_sender = 'please-change-me@config-initializers-devise.com'
end
```

and you need to specify email credentials in production.rb

add `gem 'aws-sdk'` refering to https://guides.spreecommerce.com/developer/s3_storage.html



Testing
-------

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_finda_doc/factories'
```

Copyright (c) 2015 [name of extension creator], released under the New BSD License
