require 'spec_helper'

feature "help message displayed spec" do
  
  scenario "sees message" do 
    ActionMailer::Base.deliveries = []
    shop = Fabricate(:shop)
    page = Fabricate(:page, shop: shop, shopify_page_type: "pages")
    store = Fabricate(:store, page: page)
    insight = Fabricate(:insight, shop: shop, page: page)
    
    visit insights_shop_pages_path(shop)
    click_link "Click this link if you need help writing SEO copy that will help you sell and convert"
    
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end


