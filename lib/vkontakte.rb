module Vkontakte
  autoload :Oauth, 'vkontakte/oauth'
  autoload :View,  'vkontakte/view'
  autoload :Utils, 'vkontakte/utils'
  autoload :Api,   'vkontakte/api'
  autoload :Logger, 'logger'

  class << self
    def button(*args)
      Vkontakte::View::button_tag(*args)
    end
    
    def authorized?(cookies)
      params = Vkontakte::Utils.parse_query(cookies[Vkontakte::Oauth.cookie_name])
      Vkontakte::Oauth.authorized?(params)
    end
    
    def user_data(cookies, options = {})
      params = Vkontakte::Utils.parse_query(cookies[Vkontakte::Oauth.cookie_name])
      options.update :uids => cookies['mid']
      
      if Vkontakte::Oauth.authorized?(params)
        data = begin
          Vkontakte::Api.call("getProfiles", options, params)
        rescue ServerError
          return nil if $!.to_s=~/Data not found/
          raise
        end
      else
        return nil
      end
    end
    
    def logger
      Vkontakte::Oauth.logger
    end
  end
  
  class ServerError < RuntimeError; end #backwards compatibility / catch all
  class ApiError < ServerError; end
  class ServiceUnavailableError < ServerError; end
end
