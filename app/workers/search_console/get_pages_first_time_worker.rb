require 'signet/oauth_2/client'
require 'google/api_client/client_secrets.rb'
require 'google/apis/webmasters_v3'

class SearchConsole::GetPagesFirstTimeWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id)
    shop = Shop.find_by id: shop_id
    if shop.google_website
      service = Google::Apis::WebmastersV3::WebmastersService.new
      service.authorization = google_secret(shop).to_authorization
      service.authorization.refresh!
      startTime = (Time.current - 93.days).strftime("%Y-%m-%d")
      endTime = (Time.current - 3.days).strftime("%Y-%m-%d")
      
      data_page_query_first = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new(start_date: startTime, end_date: endTime, dimensions: ["page", "query"], row_limit: "25000", start_row: "0")
      results_page_query_first = service.query_search_analytics("#{shop.google_website}", data_page_query_first)
      data_page_query_second = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new(start_date: startTime, end_date: endTime, dimensions: ["page", "query"], row_limit: "25000", start_row: "25000")
      results_page_query_second = service.query_search_analytics("#{shop.google_website}", data_page_query_second)
      
      binding.pry
      
      #first 25000 rows
      if results_page_query_first.rows != nil
        results_page_query_first.rows.each do |row|
          SearchConsole::SavePageKeywordWorker.perform_async(shop.id, row)
        end
      end
      
      #second 25000 rows
      if results_page_query_second.rows != nil
        results_page_query_second.rows.each do |row|
          SearchConsole::SavePageKeywordWorker.perform_async(shop.id, row)
        end
      end
      
      
      #get all pages that are products or collection pages
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(2.minutes, shop.id)
      #5
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(5.minutes, shop.id)
      #10
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(10.minutes, shop.id)
      #15
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(15.minutes, shop.id)
      #30
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(30.minutes, shop.id)
      #60
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(60.minutes, shop.id)
      #90
      Shops::CalculateCtrBrandedKeywordsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrAllWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrProductsCollectionsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrPagesWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrBlogsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrFourKeywordsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrThreeKeywordsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrTwoKeywordsWorker.perform_in(90.minutes, shop.id)
      Shops::CalculateCtrOneKeywordWorker.perform_in(90.minutes, shop.id)
      
      #sum all page stats properly 
      Shops::CalculateStatsWorker.perform_in(2.minutes, shop.id)
      Shops::CalculateStatsWorker.perform_in(5.minutes, shop.id)
      Shops::CalculateStatsWorker.perform_in(10.minutes, shop.id)
      Shops::CalculateStatsWorker.perform_in(15.minutes, shop.id)
      Shops::CalculateStatsWorker.perform_in(30.minutes, shop.id)
      Shops::CalculateStatsWorker.perform_in(60.minutes, shop.id)
      Shops::CalculateStatsWorker.perform_in(90.minutes, shop.id)
    end
  end
  
  def google_secret(shop)
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => shop.google_token,
          "refresh_token" => shop.google_refresh_token,
          "client_id" => "489705980657-8us4ok0caae4mc8kggs24q7818iu695p.apps.googleusercontent.com",
          "client_secret" => "yUm-0m8e0UhZwCcAMfWGD9rZ"
        }
      })
  end
end
