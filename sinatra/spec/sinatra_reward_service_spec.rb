require "spec_helper"

# NOTE: These tests rely on the EligibilityService always responding with 'CUSTOMER_ELIGABLE'

describe SinatraRewardService do
  describe "When parameters are missing" do
    before { get '/' }
    it "should respond with an error" do
      expect(last_response.status).to eq 400
    end
    it "should display a bad request method" do
      expect(last_response.body).to include "Bad Request"
    end
  end

  describe "When the correct parameters are provided and a single channel has no reward" do
    before { get '/?account_number=123&portfolio=kids' }
    it "should respond with no error" do
      expect(last_response.status).to eq 200
    end
    it "should return the correct data" do
      expect(last_response.body).to eq "{\"rewards\":[]}"
    end
  end

  describe "When the correct parameters are provided and multiple channels have associated rewards" do
    before { get '/?account_number=123&portfolio=kids,music,news,movies' }
    it "should respond with no error" do
      expect(last_response.status).to eq 200
    end
    it "should return the correct data" do
      expect(last_response.body).to eq "{\"rewards\":[\"KARAOKE_PRO_MICROP\",\"PIRATES_OF_THE_CARIBBEAN_COLLECTION\"]}"
    end
  end
end
