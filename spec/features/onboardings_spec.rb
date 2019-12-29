require 'spec_helper'

feature "onboarding" do
  
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
  
  def stub_omniauth
    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "102250334382858209192",
      info: {
        email: "arjunrajkumars@gmail.com"
      },
      credentials: {
        token: "ya29.Il-3B_mtDRG9T8TY7Bq-zLPiLsJ77KqpWZhgfuSUETcqEwI984AP28kpMTwGbhoscMIUcF5aU6dLa6YHqC8mbaCWPLvKslNJ-y1Cidy24IwC_pSFLRwheuPHnKxmZRblQg",
        refresh_token: "1//0gVrXyGs_ocN2CgYIARAAGBASNwF-L9IrXD8hsqUJm044dFUEXuvWImubWc1wzs6Ign0YSum86ZU4VDV38R91QcOlj_nIIH9gYns",
        expires_at: DateTime.now,
      }
    })
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end
  
  scenario "new user sign in via Shopify" do 
    visit root_path
    expect(page).to have_content "Enter your shop domain to log in or install this app."
    
    shop = Fabricate(:shop)
    login(shop)
    expect(page).to have_content "1/5 steps completed"
    
    click_button "Save"
    expect(page).to have_content "1/5 steps completed"
    fill_in "Enter Shop/Brand Name", with: "Monk"
    click_button "Save"
    
    expect(page).to have_content '2/5 steps completed'
    
    #click_link "Connect Google Search Console"
    stub_omniauth
    
    visit select_website_path
    
    expect(page).to have_content '3/5 steps completed'
    select "https://arjun-shop.myshopify.com/", from: "selected_website" 
    click_button "Next" 


    expect(page).to have_content '4/5 steps completed'
  end
end

