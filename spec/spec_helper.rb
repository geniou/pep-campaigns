require 'rubygems'
require 'spork'
require 'capybara/poltergeist'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'database_cleaner'

  Capybara.javascript_driver = :poltergeist

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true

    require Rails.root.join("spec/support/admin.rb")
    config.include SpecAdmin

    config.include FactoryGirl::Syntax::Methods

    config.before(:each) do
      if example.metadata[:js]
        config.use_transactional_fixtures = false
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
      end
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end

end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
  FactoryGirl.reload
end

