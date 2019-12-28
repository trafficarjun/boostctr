class Page < ApplicationRecord
  validates_uniqueness_of :url, :scope => :shop_id
  
  belongs_to :shop
  validates_presence_of :url
  include Sluggable
  sluggable_column :url
  
  after_create :save_handle_shopify_type
  

  def save_handle_shopify_type
    url = self.url
    url = url.sub(/(\/)+$/,'')
    begin 
      url.slice! self.shop.google_website
      handle = url.match(/\/([^\/]+)\/?$/)[1]
    rescue 
      #error occurs when url does not contain a /
      puts "error inside page.rb"
      puts url
    else
      if url.include? "products"
        self.update(shopify_page_type: "products", handle: handle)
      elsif url.include? "pages"
        self.update(shopify_page_type: "pages", handle: handle)
      elsif url.include? "collections"
        self.update(shopify_page_type: "collections", handle: handle)
      elsif url.include? "blogs"
        self.update(shopify_page_type: "blogs", handle: handle)
      else
        self.update(shopify_page_type: "frontpage", handle: "frontpage")
      end
    end
  end
  
  def all_tests_over
    !self.tests.map{|test| test.is_test_over }.include? false
  end
end
