require 'spec_helper'

feature "admin views seo tests" do
  scenario "sees tests" do 
    arjun = Fabricate(:user)
    sign_in(arjun)
    
    shop = Fabricate(:shop)
    page = Fabricate(:page, shop: shop, shopify_page_type: "pages")
    seo_test = Fabricate(:test, shop: shop, page: page)
    
    visit admin_tests_path
    click_link "End Test"
  end  
end