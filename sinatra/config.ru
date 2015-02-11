require 'bundler/setup'
require 'sinatra/base'
require 'json'

# Development Requires
if ENV['RACK_ENV'] == "development"
  require 'pry'
end

require './sinatra_reward_service'

run SinatraRewardService
