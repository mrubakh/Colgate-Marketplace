def login
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  visit root_path
  click_link 'Log in with Google SSO'
end