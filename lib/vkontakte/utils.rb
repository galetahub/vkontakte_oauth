require 'digest/md5'
require 'json'

module Vkontakte
  module Utils
    def self.generate_cookie_sign(data, app_secret)
      Digest::MD5.hexdigest(collect_params(data) + app_secret)
    end

    def self.generate_api_sign(cookies, data)
      cookies['secret'] ||= Vkontakte::Oauth.app_secret
      Digest::MD5.hexdigest([cookies['mid'], collect_params(data), cookies['secret']].join)
    end
    
    def self.collect_params(data)
      data.sort{|a, b| a.first.to_s <=> b.first.to_s}.collect{|key, value| "#{key}=#{value}"}.join
    end
    
    def self.turn_into_json(data)
      if Object.const_defined?('ActiveSupport')
        ActiveSupport::JSON.encode(data)
      else
        JSON.generate(data)
      end
    end
    
    def self.parse_query(value, spliter = '&')
      Rack::Utils.parse_query(value, spliter).inject({}) {|h,(k,v)|
        h[k] = Array === v ? v.first : v
        h
      }
    end
    
    def self.new_safe_buffer
      if Object.const_defined?('ActiveSupport')
        ActiveSupport::SafeBuffer.new
      else
        String.new
      end
    end
  end
end
