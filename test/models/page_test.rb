require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test "page belongs to shop" do
    page = Page.new
    assert page.invalid?
  end
  
  test "page URL must not be empty" do
    shop = shops(:regular_shop)
    page = shop.pages.new
    assert page.invalid?
    assert page.errors[:url].any?
  end
  
  test "page URL must be uniqie to shop" do
    shop = shops(:regular_shop)
    page = shop.pages.create(url: 'first_url')
    assert page.valid?
    duplicate_page = shop.pages.create(url: 'first_url')
    assert duplicate_page.invalid?
  end
  
  test 'page saves handle and shopify_id automatically' do 
    shop = shops(:regular_shop)
    page = shop.pages.create(url: 'regular-shop.myshopify.com/products/bmw')
    assert_equal 'products', page.shopify_page_type
    assert_equal 'bmw', page.handle
  end
end
