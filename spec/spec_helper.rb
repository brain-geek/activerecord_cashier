require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'cashier'
require 'redis'
require 'dalli'

require 'pry'
require 'pry-nav'

Combustion.initialize! :all

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.before(:suite) do
    Cashier::Adapters::RedisStore.redis = Redis.new(:host => '127.0.0.1', :port => 6379)
  end

  config.before(:each) do
    Cashier::Adapters::RedisStore.redis.flushdb
    Rails.cache.clear
  end
end

ApplicationController.perform_caching = true