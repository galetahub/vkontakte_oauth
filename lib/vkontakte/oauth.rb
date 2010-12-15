require 'uri'
require 'logger'

module Vkontakte
  module Oauth
    # http://vkontakte.ru/pages.php?o=-1&p=Open%20API
    mattr_accessor :app_id
    @@api_id = "ID приложения"
    
    mattr_accessor :app_secret
    @@app_secret = "Защищенный ключ"
    
    # nameTransportPath
    mattr_accessor :xd_receiver_path
    @@xd_receiver_path = "/xd_receiver.html"
    
    # http://vkontakte.ru/page2369497
    mattr_accessor :api_url
    @@api_url = "http://api.vkontakte.ru/api.php"
    
    mattr_accessor :api_version
    @@api_version = '2.0'
    
    mattr_accessor :logger
    @@logger = nil
    
    def self.logger
      @@logger ||= begin
        log = Logger.new(STDOUT)
        log.level = Logger::INFO
        log
      end
    end
        
    def self.api_uri
      @@api_uri ||= URI.parse(@@api_url)
      @@api_uri
    end
    
    def self.cookie_name
      "vk_app_#{@@app_id}"
    end
    
    # http://vkontakte.ru/pages.php?o=-1&p=VK.Auth
    def self.authorized?(cookies, app_secret_value = nil)
      app_secret_value ||= @@app_secret
      
      cookies['sig'] == Vkontakte::Utils.generate_cookie_sign({
        :expire => cookies['expire'],
        :mid    => cookies['mid'],
        :secret => cookies['secret'],
        :sid    => cookies['sid']}, app_secret_value)
    end
    
    # Default way to setup Vkontakte::Oauth. Run rails generate vkontakte to create
    # a fresh initializer with all configuration values.
    def self.setup
      yield self
    end
  end
end
