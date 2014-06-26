class ApiRequest < ActiveRecord::Base
  include HTTParty
  no_follow true
  def self.get_profile(user_id)
    UserToken.get_token
  end
  def self.get_trophies(user_id)
    UserToken.get_token
  end
  def self.get_trophies_by_game(user_id, game_id)
    UserToken.get_token
  end
  def self.get_trophy(user_id, game_id, trophy_id)
    tokens = UserToken.get_token
    oauth_token = tokens["oauth_token"]
    uri = ('https://us-tpy.np.community.playstation.net/trophy/v1/trophyTitles/game_id/trophyGroups/all/trophies/trophy_id?fields=%40default,trophyRare,trophyEarnedRate&npLanguage=en&comparedUser=user_id')
    uri.gsub!(/user_id/, user_id)
    uri.gsub!(/game_id/, game_id)
    uri.gsub!(/trophy_id/, trophy_id)
    response = ApiRequest.get(uri,
                          :headers => {'Access-Control-Request-Method'  => 'GET',
                                       'Origin'                         => 'http://psapp.dl.playstation.net',
                                       'Access-Control-Request-Headers' => 'Origin, Accept-Language, Authorization, Content-Type, Cache-Control',
                                       'Accept-Language'                => 'en',
                                       'Authorization'                  => 'Bearer ' + oauth_token,
                                       'Cache-Control'                  => 'no-cache',
                                       'X-Requested-With'               => 'com.scee.psxandroid',
                                       'User-Agent' => 'Mozilla/5.0 (Linux; U; Android 4.3; en; C6502 Build/10.4.1.B.0.101) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30 PlayStation App/1.60.5/en/en'})
    puts response
  end
end
