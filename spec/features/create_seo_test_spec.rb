require 'spec_helper'

feature "create seo test" do
  
  #visit insights page to see low perfoming SEO pages
  #click on different set of pages
  #start test
  
  scenario "starting first test" do 
    shop = Fabricate(:shop)
    page = Fabricate(:page, shop: shop, shopify_page_type: "pages")
    store = Fabricate(:store, page: page)
    insight = Fabricate(:insight, shop: shop, page: page)
    10.times do |i|
      Fabricate(:click, ctr_type: "pages", rank: i, ctr: i, shop: shop)
    end
    
    visit insights_shop_pages_path(shop)
    click_link "Other Pages"
    
    click_link "Tests"
    fill_in "test_title", with: "This is the new title"
    fill_in "test_description", with: "This is the new description"
    click_button "Save Start Test"
  end
end


