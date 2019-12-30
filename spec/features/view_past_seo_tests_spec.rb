require 'spec_helper'

feature "view past seo tests" do
  
  #click page/show or test/index
  #view past tests
  #click on-going test
  #end test and verify its over
  
  scenario "tests index" do 
    shop = Fabricate(:shop)
    page = Fabricate(:page, shop: shop, shopify_page_type: "pages")
    seo_test = Fabricate(:test, shop: shop, page: page)
    visit shop_tests_path(shop)
    click_link "Ongoing"
    click_link "End Test"
    visit shop_tests_path(shop)
    click_link "Test Finished"
  end 
  
  scenario "page show" do 
    shop = Fabricate(:shop)
    page = Fabricate(:page, shop: shop, shopify_page_type: "pages")
    seo_test = Fabricate(:test, shop: shop, page: page)
    visit shop_page_path(shop, page)  
    click_link "Ongoing"
    click_link "End Test"
    visit shop_tests_path(shop)
    click_link "Test Finished"
  end 
end


