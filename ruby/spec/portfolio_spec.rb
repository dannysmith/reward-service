require "spec_helper"
require_relative '../lib/portfolio'

describe Portfolio do
  context "for a series of symbols" do
    it "should return an array of symbolized subscriptions" do
      portfolio = Portfolio.new :sports, :kids, :music, :news, :movies
      expect(portfolio.channels).to eq [:sports, :kids, :music, :news, :movies]
    end
  end

  context "for capitalised strings" do
    it "should convert strings to lowercase symbols" do
      portfolio = Portfolio.new "Sports", "Kids"
      expect(portfolio.channels).to eq [:sports, :kids]
    end
  end
end
