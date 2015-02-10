require 'yaml'
require_relative 'customer_status/eligability_service'
require_relative 'exceptions/invalid_account_number'

class RewardService
  attr_reader :channel_rewards

  def initialize(account_number,
                 portfolio,
                 eligability_service = CustomerStatus::EligabilityService.new(account_number),
                 channel_rewards_path = 'data/channel_rewards.yml')

    raise "portfolio is not a Portfolio" unless portfolio.is_a? Portfolio

    @account_number = account_number.to_s # Accepts integers or strings
    @portfolio = portfolio
    @eligability_service = eligability_service
    @channel_rewards = YAML.load(File.open(File.expand_path("..", File.dirname(__FILE__)) + "/../" + channel_rewards_path))
  end

  def rewards
    @rewards ||= check_if_eligable
  end



  private

  def check_if_eligable
    begin
      eligability = @eligability_service.eligability
    rescue InvalidAccountNumber
      return "Invalid Account Number"
    rescue StandardError
      return []
    end

    if eligability == "CUSTOMER_ELIGIBLE"
      return fetch_rewards
    else
      return []
    end
  end

  def fetch_rewards
    # Keep only relevant rewards
    rewards = @channel_rewards.select {|k,v| @portfolio.to_a.include? k}
    rewards = rewards.select {|k,v| v != "N/A"}
    rewards.values.reject(&:nil?) # Remove nil rewards
  end
end
