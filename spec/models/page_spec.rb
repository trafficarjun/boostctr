require 'spec_helper'

describe Page do 
  it "saves itself" do 
    shop = Fabricate(:shop)
    page = shop.pages.new(url: 'first_url')
    page.save
    expect(Page.first).to eq(page)
  end
  it "belongs to shop" do 
    shop1 = Shop.new(shopify_domain: "example.com", shopify_token: "token")
    shop1.save
    page1 = Page.new(url: "example.com/products", shop: shop1)
    page1.save
    expect(Page.first.shop).to eq(shop1)
  end
  it "URL must not be empty" do 
    shop = Fabricate(:shop)
    page = shop.pages.new()
    page.save
    expect(shop.pages.count).to eq(0)
  end
  it "URL must be unique to shop" do 
    shop = Fabricate(:shop)
    page = shop.pages.new(url: 'url')
    page.save
    dup_page = shop.pages.new(url: 'url')
    dup_page.save
    expect(shop.pages.count).to eq(1)
  end
  it "saves handle and shopify_id automatically" do 
    shop = Fabricate(:shop)
    shop.update(google_website: 'regular-shop.myshopify.com')
    page = shop.pages.new(url: 'regular-shop.myshopify.com/products/bmw')
    page.save
    expect(page.shopify_page_type).to eq('products')
    expect(page.handle).to eq('bmw')
  end
end
