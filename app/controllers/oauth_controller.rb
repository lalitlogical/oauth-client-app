# app/controllers/oauth_controller.rb
class OauthController < ApplicationController
  def login
    redirect_to OAUTH_CLIENT.auth_code.authorize_url(
      redirect_uri: callback_url
    )
  end

  def callback
    token = OAUTH_CLIENT.auth_code.get_token(
      params[:code],
      redirect_uri: callback_url
    )

    session[:access_token] = token.token
    redirect_to root_path
  end

  def protected
    token = OAuth2::AccessToken.new(OAUTH_CLIENT, session[:access_token])
    response = token.get("/api/v1/me")
    render plain: response.body
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out!"
  end

  private

  def callback_url
    "#{request.base_url}/callback"
  end
end
