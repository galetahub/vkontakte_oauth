module Vkontakte
  module View
    
    @@default_options = {
      :id => 'vk_login',
      :asynchronous => false,
      :callback => "/vkontakte"
    }
    
    # Vkontakte button 
    #   Vkontakte.button
    #   Vkontakte.button(:asynchronous => true, :id => "vk_button_tag")
    #
    def self.button_tag(options = {})
      options = @@default_options.merge(options)
      
      html = Vkontakte::Utils.new_safe_buffer
      html << "<div id='#{options[:id]}' class='vk_login' onclick='vkontakte.login();'></div>".html_safe
      html << '<div id="vk_api_transport"></div>'.html_safe
      html << (options[:asynchronous] ? js_asynchronous(options) : js_original(options)).html_safe
      html
    end
    
    private
      
      def self.js_asynchronous(options = {})
        <<-EOF
          <script type="text/javascript">
            window.vkAsyncInit = function() {
              VK.Observer.subscribe('auth.login', function(response) {
                vkontakte.callback('#{options[:callback]}');
              });

              #{js_vk_init}
              
              #{js_vk_ui_button(options)}
            };

            (function() {
              var el = document.createElement("script");
              el.type = "text/javascript";
              el.charset = "windows-1251";
              el.src = "http://vkontakte.ru/js/api/openapi.js";
              el.async = true;
              document.getElementById("vk_api_transport").appendChild(el);
            }());
          </script>
        EOF
      end
      
      def self.js_original(options = {})
        <<-EOF
          <script src="http://vkontakte.ru/js/api/openapi.js" type="text/javascript" charset="windows-1251"></script>
          <script type="text/javascript">
            #{js_vk_init}
            
            VK.Observer.subscribe('auth.login', function(response) {
              vkontakte.callback('#{options[:callback]}');
            });
            
            #{js_vk_ui_button(options)}
          </script>
        EOF
      end
      
      def self.js_vk_init
        <<-EOF
          VK.init({
            apiId: #{Vkontakte::Oauth.app_id},
            nameTransportPath: "#{Vkontakte::Oauth.xd_receiver_path}"
          });
        EOF
      end
      
      def self.js_vk_ui_button(options)
        "VK.UI.button('#{options[:id]}');"
      end
  end
end
