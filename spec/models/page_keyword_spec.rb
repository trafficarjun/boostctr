require 'spec_helper'

describe PageKeyword do 
  it "Keyword must be unique to page" do 
    shop = Fabricate(:shop)
    page = Fabricate(:page, shop: shop, shopify_page_type: "pages")
    keyword = Fabricate(:keyword, shop: shop)
    page_keyword = PageKeyword.create(keyword_id: keyword.id, page_id: page.id, shop_id: shop.id)
    dup_page_keyword = PageKeyword.create(keyword_id: keyword.id, page_id: page.id, shop_id: shop.id)
    expect(page.keywords.count).to eq(1)
  end
end