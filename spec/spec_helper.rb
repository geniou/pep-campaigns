require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'

  Capybara.javascript_driver = :webkit

  RSpec.configure do |config|
    config.include FactoryGirl::Syntax::Methods

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end

end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  FactoryGirl.reload

end

