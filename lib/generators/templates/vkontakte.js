var vkontakte = {
  baseURL: window.location.protocol + '//' + window.location.hostname + '/',

  login: function () {
    VK.Auth.login(
      null,
      VK.access.FRIENDS | VK.access.WIKI
    );
  },
  
  callback: function(url){
    // window.location = this.baseURL + '/vkontakte';
    
    var f = document.createElement('form'); 
    f.style.display = 'none'; 
    document.body.appendChild(f); 
    f.method = 'POST'; 
    f.action = url;
    
    if protect_against_forgery?
          token_tag = <<-EOF
            var s = document.createElement('input'); 
            s.setAttribute('type', 'hidden'); 
            s.setAttribute('name', 'authenticity_token'); 
            s.setAttribute('value', '#{form_authenticity_token}');
            f.appendChild(s);
          EOF
        end
    
    f.submit();
  }
};
