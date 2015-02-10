require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
require 'rspec'

# Require the sinatra app
# require_relative File.join('..', 'ruby_reward_service')


# Configure RSpec
RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
