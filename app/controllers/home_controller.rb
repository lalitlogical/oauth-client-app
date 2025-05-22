class HomeController < ApplicationController
  def index
    if session[:access_token]
      puts token = OAuth2::AccessToken.new(OAUTH_CLIENT, session[:access_token])
      # response = token.get("/api/v1/me")
      # render plain: response.body
    end
  end
end
