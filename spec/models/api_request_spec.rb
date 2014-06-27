require 'rails_helper'

RSpec.describe ApiRequest, :type => :model do
  describe "#get_profile"  do
    it "should return a user profile" do
      profile = ApiRequest.get_profile('studentnss')
      expect(profile).to match(/"onlineId": "studentnss"/)
    end
  end
  describe "#get_trophies"  do
    it "should return a user's trophy list" do
      trophies = ApiRequest.get_trophies('studentnss')
      expect(trophies).to match(/"trophyTitleName": "Diablo III"/)
    end
  end
  describe "#get_trophies_by_game"  do
    it "should return a games trophy list" do
      game_trophies = ApiRequest.get_trophies_by_game('studentnss','NPWR04150_00')
      expect(game_trophies).to match(/"trophyName": "Diablo III Platinum Trophy"/)
      expect(game_trophies).to match(/"trophyId": 0/)
      expect(game_trophies).to match(/"trophyId": 45/)
    end
  end
  describe "#get_trophy"  do
    it "should return a trophy" do
      trophy = ApiRequest.get_trophy('studentnss','NPWR04150_00','28')
      expect(trophy).to match(/"trophyName": "Legends of the Brawl"/)
      expect(trophy).to match(/"trophyId": 28/)
    end
  end
end
