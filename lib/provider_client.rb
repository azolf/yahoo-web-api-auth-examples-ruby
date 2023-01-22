module RubyOuath
  class ProviderClient
    def self.redirect_uri(state)
      params = {
        response_type: 'code',
        client_id: RubyOuath.configuration.client_id,
        redirect_uri: RubyOuath.configuration.callback_url,
        state: state
      }
      uri = URI('https://api.login.yahoo.com/oauth2/request_auth')
      uri.query = URI.encode_www_form(params)

      uri
    end

    def self.get_token_by_code(code)
      data = {
        code: code,
        redirect_uri: RubyOuath.configuration.callback_url,
        client_id: RubyOuath.configuration.client_id,
        client_secret: RubyOuath.configuration.client_secret,
        grant_type: 'authorization_code'
      }

      res = RestClient.post(
        'https://api.login.yahoo.com/oauth2/get_token',
        data,
        {
          accept: :json
        }
      )

      result = JSON.parse(res.body)
    end

    def self.update_token(refresh_token)
      url = 'https://api.login.yahoo.com/oauth2/get_token'
      data = {
        refresh_token: refresh_token,
        grant_type: 'refresh_token',
        redirect_uri: RubyOuath.configuration.callback_url,
        client_id: RubyOuath.configuration.client_id,
        client_secret: RubyOuath.configuration.client_secret
      }
      res = RestClient.post(url,
        data,
        {
          accept: :json
        })
      JSON.parse(res.body)
    end

    def self.user_info(token)
      url = 'https://api.login.yahoo.com/openid/v1/userinfo/'

      res = RestClient.get url, {
        Authorization: token
      }

      JSON.parse(res.body)
    end
  end
end