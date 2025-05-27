class OauthLoginService
  def initialize(code, redirect_uri)
    @code = code
    @redirect_uri = redirect_uri
  end

  def authenticate
    token = client.auth_code.get_token(@code, redirect_uri: @redirect_uri)
    user_info = JSON.parse(token.get("/oauth/userinfo").body)

    if email ||= user_info.try(:[], "email")
      user = User.find_or_create_by(email: email) do |u|
        u.password = Devise.friendly_token[0, 20]
      end

      return user if user.persisted?
    end

    nil
  end

  private

  def client
    OAuth2::Client.new(
      ENV["OAUTH_CLIENT_ID"],
      ENV["OAUTH_CLIENT_SECRET"],
      site: ENV["BACKEND_OAUTH_HOST"]
    )
  end
end
