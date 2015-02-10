require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)
require 'rspec'

# Configure RSpec
RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end
