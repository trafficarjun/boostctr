require 'spec_helper'

describe Keyword do 
  it "Name must be unique to shop" do 
    shop = Fabricate(:shop)
    keyword = shop.keywords.new(name: 'buy red shoes')
    keyword.save
    dup_keyword = shop.keywords.new(name: 'buy red shoes')
    dup_keyword.save
    expect(shop.keywords.count).to eq(1)
  end
end
