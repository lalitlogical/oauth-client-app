# app/controllers/oauth_controller.rb
class OauthController < ApplicationController
  def login
    redirect_to OAUTH_CLIENT.auth_code.authorize_url(
      redirect_uri: callback_url
    )
  end

  def callback
    if params[:error].present?
      flash[:error] = params[:error_description]
      redirect_to root_path
    else
      token = OAUTH_CLIENT.auth_code.get_token(
        params[:code],
        redirect_uri: callback_url
      )

      response = token.get("/oauth/userinfo")
      user_info = JSON.parse(response.body)

      user = User.find_or_create_by(email: user_info["email"]) do |u|
        u.password = Devise.friendly_token[0, 20]
      end

      if user.persisted?
        sign_in_and_redirect user, event: :authentication
      else
        redirect_to root_path, alert: "Could not authenticate."
      end
    end
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
