class UserToken < ActiveRecord::Base
  include HTTParty
  no_follow true
  def self.get_token
    init_login
    post_login
    get_auth_code
    get_oauth_token
    tokens = Hash['oauth_token' => @oauth_token, 'refresh_token' => @refresh_token]
  end
  private
  def self.init_login
    uri = ('https://auth.api.sonyentertainmentnetwork.com/2.0/oauth/authorize?response_type=code&service_entity=urn:service-entity:psn&returnAuthCode=true&cltm=1399637146935&redirect_uri=com.scee.psxandroid.scecompcall://redirect&client_id=b0d0d7ad-bb99-4ab1-b25e-afa0c76577b0&scope=psn:sceapp')
    begin
      UserToken.get(uri, :headers => {'User-Agent' => 'Mozilla/5.0 (Linux; U; Android 4.3; en; C6502 Build/10.4.1.B.0.101) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30 PlayStation App/1.60.5/en/en'})
    rescue HTTParty::RedirectionTooDeep => e
      @location = e.response["location"]
      @cookie = e.response['set-cookie']
    end
  end
  def self.post_login
    uri = ('https://auth.api.sonyentertainmentnetwork.com/login.do')
    begin
      response = UserToken.post(uri,
                            :body => {   'params' => 'service_entity=psn',
                                         'j_username' => 'studentpsn@gmail.com',
                                         'j_password' => 'psnapi@test'},
                            :headers => {'Origin' => 'https://auth.api.sonyentertainmentnetwork.com',
                                         'Referer' => @location,
                                         'Cookie' => @cookie })
    rescue HTTParty::RedirectionTooDeep => e
      @location = e.response["location"]
    end
  end
  def self.get_auth_code
    uri = @location
    begin
      response = UserToken.get(uri, :headers => {'User-Agent' => 'Mozilla/5.0 (Linux; U; Android 4.3; en; C6502 Build/10.4.1.B.0.101) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30 PlayStation App/1.60.5/en/en',
                                                 'Cookie' => @cookie})
    rescue HTTParty::RedirectionTooDeep => e
      enc_uri = e.response.header["location"]
    end
    uri_w_auth_code = URI.unescape(enc_uri)
    @auth_code = uri_w_auth_code[(uri_w_auth_code.index("authCode=")+9),6]
  end
  def self.get_oauth_token
    uri = ('https://auth.api.sonyentertainmentnetwork.com/2.0/oauth/token')
    response = UserToken.post(uri,
                             :body => { 'grant_type'    => 'authorization_code',
                                        'client_id'     => 'b0d0d7ad-bb99-4ab1-b25e-afa0c76577b0',
                                        'client_secret' => 'Zo4y8eGIa3oazIEp',
                                        'redirect_uri'  => 'com.scee.psxandroid.scecompcall://redirect',
                                        'state'         => 'x',
                                        'scope'         => 'psn:sceapp',
                                        'duid'          => '00000005006401283335353338373035333434333134313a433635303220202020202020202020202020202020',
                                        'code'          => @auth_code })
    @oauth_token = response["access_token"]
    @refresh_token = response["refresh_token"]
  end
end
