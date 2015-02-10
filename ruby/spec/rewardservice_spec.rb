require "spec_helper"
require_relative '../lib/reward_service'

describe RewardService do
  let(:account_number) { '123456' }
  let(:portfolio) { Portfolio.new :kids, :sports, :music }
  let(:rewardservice) { RewardService.new account_number, portfolio}

  context "when an account is eligable for rewards" do

    # Set up EligabilityService Mock
    before do
      allow(CustomerStatus::EligabilityService).to receive(:new).and_return(double "EligabilityService", eligability: "CUSTOMER_ELIGIBLE")
    end

    describe "and a single channel has no reward" do
      let(:portfolio) { Portfolio.new :news }
      it "should not return any rewards" do
        expect(rewardservice.rewards).to eq []
      end
    end

    describe "and a single channel has an associated reward" do
      let(:portfolio) { Portfolio.new :sports }
      it "should return the correct reward" do
        expect(rewardservice.rewards).to eq ["CHAMPIONS_LEAGUE_FINAL_TICKET"]
      end
    end

    describe "and some channels have rewards while others don't" do
      let(:portfolio) { Portfolio.new :kids, :music, :news, :movies }
      it "should return the rewards for channels that have them" do
        expect(rewardservice.rewards).to eq ["KARAOKE_PRO_MICROP", "PIRATES_OF_THE_CARIBBEAN_COLLECTION"]
      end
    end
  end

  context "when an account is NOT eligable for rewards" do
    it "should return no awards" do
      allow(CustomerStatus::EligabilityService).to receive(:new).and_return(double "EligabilityService", eligability: "CUSTOMER_INELIGIBLE")
      expect(rewardservice.rewards).to eq []
    end
  end

  context "when an invalid account number is supplied" do
    it "should return a string warning of the invalid account number" do
      allow_any_instance_of(CustomerStatus::EligabilityService).to receive(:eligability).and_raise(InvalidAccountNumber)
      expect(rewardservice.rewards).to eq "Invalid Account Number"
    end
  end

  context "when a technical error occus on the EligabilityService" do
    it "should return no awards" do
      allow_any_instance_of(CustomerStatus::EligabilityService).to receive(:eligability).and_raise(StandardError)
      expect(rewardservice.rewards).to eq []
    end
  end
end
