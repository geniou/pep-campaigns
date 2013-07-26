source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '~> 4.0.0'
gem 'pg'
gem 'jquery-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'haml-rails'
gem 'uglifier'
gem 'devise'
gem 'formtastic', github: 'justinfrench/formtastic'
gem "bcrypt-ruby", require: "bcrypt"
gem 'exception_notification', require: 'exception_notifier'

group :test, :development do
  gem "rspec-rails"
  gem 'capybara'
  gem 'database_cleaner'
  gem 'spork-rails', github: 'railstutorial/spork-rails'
  gem 'capistrano'
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'poltergeist'
end

group :development do
  gem 'erd'
end

group :production do
  gem 'therubyracer'
end
