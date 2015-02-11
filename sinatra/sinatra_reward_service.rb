require_relative '../ruby/lib/portfolio'
require_relative '../ruby/lib/reward_service'

# Quick and dirty mock EligibilityServie that always returns CUSTOMER_ELIGIBLE
class MockEligabilityService
  def initialize(account_number);end
  def eligibility;"CUSTOMER_ELIGIBLE";end
end

# Example Sinatra wrapper
class SinatraRewardService < Sinatra::Base
  get '/' do
    unless (params[:account_number] && params[:portfolio])
      status 400
      "Bad Request"
    else
      portfolio = Portfolio.new(params[:portfolio].split(","))
      service = RewardService.new(params[:account_number], portfolio, MockEligabilityService.new(params[:account_number]))
      service.rewards.to_json
    end
  end
end
