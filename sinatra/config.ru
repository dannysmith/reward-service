require 'bundler/setup'
require 'sinatra/base'
require 'json'

require './sinatra_reward_service'

# Development Requires
if ENV['RACK_ENV'] == "development"
  require 'pry'
end

run SinatraRewardService
