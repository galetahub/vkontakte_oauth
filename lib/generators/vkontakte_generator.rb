require 'rails/generators'

class VkontakteGenerator < Rails::Generators::Base
                          
  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates/'))
  end
  
  def create_config
    template "vkontakte.rb", File.join('config', 'initializers', "vkontakte.rb")
  end
  
  def create_html
    template "xd_receiver.html", File.join('public', "xd_receiver.html")
  end
  
  def create_js
    template "vkontakte.js", File.join('public', "javascripts", "vkontakte.js")
  end
end
