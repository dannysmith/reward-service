require 'yaml'
require_relative 'customer_status/eligibility_service'
require_relative 'exceptions/invalid_account_number'

class RewardService
  attr_reader :channel_rewards

  def initialize(account_number,
                 portfolio,
                 eligibility_service = CustomerStatus::EligibilityService.new(account_number),
                 channel_rewards_path = 'data/channel_rewards.yml')

    raise "portfolio is not a Portfolio" unless portfolio.is_a? Portfolio

    @account_number = account_number.to_s # Accepts integers or strings
    @portfolio = portfolio
    @eligibility_service = eligibility_service
    @channel_rewards = YAML.load(File.open(File.expand_path("..", File.dirname(__FILE__)) + "/../" + channel_rewards_path))
  end

  def rewards
    @rewards ||= check_if_eligable
  end



  private

  def check_if_eligable
    begin
      eligibility = @eligibility_service.eligibility
    rescue InvalidAccountNumber
      return {message: "Invalid Account Number", rewards: []}
    rescue StandardError
      return {rewards: []}
    end

    if eligibility == "CUSTOMER_ELIGIBLE"
      return {rewards: fetch_rewards}
    else
      return {rewards: []}
    end
  end

  def fetch_rewards
    # Keep only relevant rewards
    rewards = @channel_rewards.select {|k,v| @portfolio.to_a.include? k}
    rewards = rewards.select {|k,v| v != "N/A"}

    # Remove nil rewards
    rewards.values.reject(&:nil?)
  end
end
