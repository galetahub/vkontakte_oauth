require 'net/http'
require 'net/https'

module Vkontakte
  class Api
    def self.call(method, data, cookies)
      options = {
        :api_id => Vkontakte::Oauth.app_id,
        :test_mode => 0,
        :method => method,
        :format => 'JSON',
        :v => Vkontakte::Oauth.api_version,
        :timestamp => Time.now.to_i
      }.merge(data)
      
      options.update(:sig => Vkontakte::Utils.generate_api_sign(cookies, options),
                     :sid => cookies['sid'])
      
      response = request(Vkontakte::Oauth.api_uri.path, options)
      parse_response(response)
    end
    
    private

    def self.request(path, data)
      client.request(request_object(path, data))
    end

    def self.request_object(path, data)
      request = Net::HTTP::Post.new(path)
      request.form_data = stringify_keys(data)
      request
    end
    
    # symbol keys -> string keys
    # because of ruby 1.9.x bug in Net::HTTP
    # http://redmine.ruby-lang.org/issues/show/1351
    def self.stringify_keys(hash)
      hash.map{|k,v| [k.to_s,v]}
    end

    def self.client
      client = Net::HTTP.new(Vkontakte::Oauth.api_uri.host, 80)
      client
    end

    def self.parse_response(response)
      if response.code.to_i >= 400
        raise ServiceUnavailableError, "The Vkontakte service is temporarily unavailable. (4XX)"
      else
        result = Vkontakte::Utils.turn_into_json(response.body)
        return result
      end
    end
  end
end
