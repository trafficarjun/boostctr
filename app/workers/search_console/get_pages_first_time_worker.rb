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
      
      #until subscribe to paid sidekiq pro - do this loop
      10.times do |i|
        n = i * i
        Shops::CalculateCtrBrandedKeywordsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrNonBrandedKeywordsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrAllWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrProductsCollectionsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrPagesWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrBlogsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrFourKeywordsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrThreeKeywordsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrTwoKeywordsWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateCtrOneKeywordWorker.perform_in(n.minutes, shop.id)
        Shops::CalculateStatsWorker.perform_in(n.minutes, shop.id)
      end
    end
  end
  
  def google_secret(shop)
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => shop.google_token,
          "refresh_token" => shop.google_refresh_token,
          "client_id" => Rails.application.credentials.google_key,
          "client_secret" => Rails.application.credentials.google_secret
        }
      })
  end
end