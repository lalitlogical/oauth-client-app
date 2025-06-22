# 🔗 OAuth Client App

A Ruby on Rails OAuth 2.0 Client that demonstrates how to **authenticate users** and **authorize machine-to-machine (M2M)** requests via an OAuth 2.0 server (e.g., your `oauth-idp-app`). Built with **OmniAuth**, **OAuth2 gem**, and **Devise**.

---

## 🧭 Features

### 👥 User Login (Authorization Code Flow)

- ✅ Login via OAuth 2.0 Authorization Code flow with IDP
- 🔁 Handles **callback**, **token exchange**, and **user creation/updating**
- 📇 Fetches user profile (name, email) via `/oauth/userinfo` or token payload

### ⚙️ Machine-to-Machine Auth (Client Credentials)

- ✅ Fetches access tokens using **client credentials**
- 🔐 Suitable for server-to-server interactions and automation

### 📦 Token & Session Management

- 🚪 Uses **Devise** to create/manage local user sessions
- 🔐 Secure storage of access and refresh tokens (DB-backed)
- 🔄 Auto-refresh tokens using `refresh_token`

### 🧩 Environment Config

- `.env`‐driven config for `OAUTH_HOST`, `OAUTH_CLIENT_ID`, `OAUTH_CLIENT_SECRET`, and scopes
- Supports customizing OAuth scopes (`openid`, `profile`, `read_data`, etc.)

---

## 🚀 Getting Started

### 1. Clone & Install

```bash
git clone https://github.com/lalitlogical/oauth-client-app.git
cd oauth-client-app
bundle install
```

### 2. Set Environment Variables

Create `.env` (or set in your shell):

```env
OAUTH_HOST=http://localhost:3000
BACKEND_OAUTH_HOST=http://localhost:3000
OAUTH_CLIENT_ID=web-frontend-app-client-id
OAUTH_CLIENT_SECRET=web-frontend-app-client-secret
SCOPES="openid profile email"
DB_HOST=localhost
DB_USERNAME=postgres
DB_PASSWORD=your-postgres-password
DB_DATABASE=oauth_client
```

### 3. Setup Database

```bash
rails db:create db:migrate
```

### 4. Start the App

```bash
rails server -p 3001
```

## 🔍 Key Routes

| Method | Path                       | Description                                       |
|--------|----------------------------|---------------------------------------------------|
| GET    | `/`                        | Home page with login or user details              |
| GET    | `/oauth/login`             | Redirects to IDP for user authentication          |
| GET    | `/oauth/callback`          | Handles OAuth 2.0 callback and signs in user      |
| DELETE | `/oauth/logout`            | Signs out user and clears Devise session          |

## ⚙️ Configuration

- `config/initializers/omniauth.rb`: Sets up Omniauth with OAuth2 strategy using IDP credentials
- `app/controllers/sessions_controller.rb`: Handles user session creation
- `app/controllers/m2m_controller.rb`: Fetches and returns M2M tokens
- `.env.example` contains variables for production/test environment

## 💡 Demo & Testing

- Navigate to `http://localhost:3001/`, click Login with IDP, and follow OAuth flow.
- Visit `http://localhost:3001/m2m_token` to see a machine token response.
- Use `/refresh_token` to renew access using the saved `refresh_token`.

## 📄 License

MIT License — feel free to use and modify!

## 🪄 Contributing

Pull requests and feature suggestions welcome!
Just fork the repo and start innovating 🎉