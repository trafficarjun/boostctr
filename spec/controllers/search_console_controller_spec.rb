require 'spec_helper'

describe SearchConsoleController do 
  describe "Downloading data" do
    it "gets data from GSC" do 
      shop = Fabricate(:shop)
      initial_pages_count = shop.pages.count
      initial_keywords_count = shop.keywords.count
      
      Sidekiq::Testing.inline! do
        shop.update(google_website: "https://arjun-shop.myshopify.com/", brand_name: 'myshopify')
        SearchConsole::GetPagesFirstTimeWorker.perform_async(shop.id)
      end
      
      expect(initial_pages_count).to_not eq(shop.pages.count)
      expect(initial_keywords_count).to_not eq(shop.keywords.count)
    end
  end
end