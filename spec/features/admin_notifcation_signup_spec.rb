require 'spec_helper'

feature "admin notification sign up" do
  
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
  
  scenario "receives email of new customer login/sign up" do 
    ActionMailer::Base.deliveries = []
    visit root_path
    shop = Fabricate(:shop)
    login(shop)
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end  
end