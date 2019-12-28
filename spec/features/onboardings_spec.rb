require 'spec_helper'

feature "user follows another user" do
  
  def login(shop)
    OmniAuth.config.mock_auth[:shopify] = nil
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:shopify] = OmniAuth::AuthHash.new({
      provider: 'shopify',
      uid: shop.shopify_domain,
      credentials: { token: shop.shopify_token }})
    
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:shopify]
    visit "/auth/shopify"
  end
  
  scenario "user following and unfollowing someone" do 
    
    visit root_path
    expect(page).to have_content "Enter your shop domain to log in or install this app."
    
    shop = Fabricate(:shop)
    login(shop)
    
    visit root_path
    expect(page).not_to have_content "Enter your shop domain to log in or install this app."
  end
end

