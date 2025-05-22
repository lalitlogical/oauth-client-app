# config/initializers/oauth_client.rb
OAUTH_CLIENT = OAuth2::Client.new(
  ENV["OAUTH_CLIENT_ID"],
  ENV["OAUTH_CLIENT_SECRET"],
  site: "http://localhost:3000",
  authorize_url: "/oauth/authorize",
  token_url: "/oauth/token"
)
