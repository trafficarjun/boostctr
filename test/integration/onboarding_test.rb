require 'test_helper'

class OnboardingTest < ActionDispatch::IntegrationTest
  def login(shop)
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:shopify, uid: shop.shopify_domain, credentials: { token: shop.shopify_token })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:shopify]

    get "/auth/shopify"
  end
  
  test "the truth" do 
    shop = shops(:regular_shop)
    login(shop)
    get '/'
    assert_response :success
  end
end