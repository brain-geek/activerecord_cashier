require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'cashier'
require 'redis'
require 'dalli'
require 'database_cleaner'

require 'pry'
require 'pry-nav'

Combustion.initialize! :all

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:suite) do
    Cashier::Adapters::RedisStore.redis = Redis.new(:host => '127.0.0.1', :port => 6379)
  end

  config.before(:each) do
    Cashier::Adapters::RedisStore.redis.flushdb
    Rails.cache.clear
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
    
  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.raise_errors_for_deprecations!  
end

ApplicationController.perform_caching = true
Cashier.adapter = :redis_store

class TrueClass
  def true?
    true
  end
end

class FalseClass
  def false?
    true
  end
end