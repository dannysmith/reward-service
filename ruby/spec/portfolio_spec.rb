require_relative '../lib/portfolio'

describe Portfolio do
  it "should return an array of symbolized subscriptions when intitialized with symbols" do
    portfolio = Portfolio.new :sports, :kids, :music, :news, :movies
    expect(portfolio.channels).to eq [:sports, :kids, :music, :news, :movies]
  end

  it "should convert strings to lowercase symbols when initializing" do
    portfolio = Portfolio.new "Sports", "Kids"
    expect(portfolio.channels).to eq [:sports, :kids]
  end
end
