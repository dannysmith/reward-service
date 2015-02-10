require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
require 'sinatra'
require 'rspec'
require 'rack/test'

# Require the sinatra app
require_relative File.join('..', 'sinatra_reward_service')

# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false

# Configure RSpec
RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation

  include Rack::Test::Methods

  def app
    SinatraRewardService
  end
end
