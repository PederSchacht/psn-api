require 'rails_helper'

RSpec.describe ApiRequest, :type => :model do
  describe "#get_profile"  do
    it "should return a user profile" do
      profile = ApiRequest.get_profile('studentnss')
    end
  end
  describe "#get_trophies"  do
    it "should return a user's trophy list" do
      trophies = ApiRequest.get_trophies('studentnss')
    end
  end
  describe "#get_trophies_by_game"  do
    it "should return a games trophy list" do
      games_trophies = ApiRequest.get_trophies_by_game('studentnss','NPWR04150_00')
    end
  end
  describe "#get_trophy"  do
    it "should return a trophy" do
      trophy = ApiRequest.get_trophy('studentnss','NPWR04150_00','28')
    end
  end
end
