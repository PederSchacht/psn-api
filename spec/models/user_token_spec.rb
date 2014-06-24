require 'rails_helper'

RSpec.describe UserToken, :type => :model do
  describe "#get_token" do
    it "should return an oauth token from a successful login" do
      token_hash = UserToken.get_token
      expect(token_hash["oauth_token"]).to match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
    end
    it "should return a refresh token" do
      token_hash = UserToken.get_token
      expect(token_hash["refresh_token"]).to match(/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/)
    end
  end
end
