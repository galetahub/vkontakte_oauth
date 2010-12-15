if Object.const_defined?('Vkontakte')
  Vkontakte::Oauth.setup do |config|
    # http://vkontakte.ru/pages.php?o=-1&p=Open%20API
    # config.app_id = "ID приложения"
    
    # config.app_secret = "Защищенный ключ"
    
    # nameTransportPath
    # config.xd_receiver_path = "/xd_receiver.html"
    
    # Vkontakte Open API
    # http://vkontakte.ru/page2369497
    # config.api_url = "http://api.vkontakte.ru/api.php"
    
    # config.api_version = '3.0'
    
    # config.logger = Rails.logger
  end
end
