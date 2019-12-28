def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "email", with: user.email
  fill_in "password", with: user.password
  click_button "Log In"
end

def login(shop)
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:shopify,
    uid: shop.shopify_domain,
    credentials: { token: shop.shopify_token })
  # And because I am using RSpec (don't know if Minitest needs this):
  Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:shopify]
  
  get "/auth/shopify"
end