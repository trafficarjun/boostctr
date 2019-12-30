require 'signet/oauth_2/client'
require 'google/api_client/client_secrets.rb'
require 'google/apis/webmasters_v3'

class SearchConsole::GetSevenFourteenAndThirtyForTestWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, testing_page_urls_for_seven_fourteen_and_thirty, gscDate)
    shop = Shop.find_by id: shop_id
    if shop && shop.google_website 
      service = Google::Apis::WebmastersV3::WebmastersService.new
      service.authorization = google_secret(shop).to_authorization
      service.authorization.refresh!
      
      one_week_before_ending_date = gscDate.to_date.strftime("%Y-%m-%d")
      one_week_before_starting_date = (gscDate.to_date - 7.days).strftime("%Y-%m-%d")
      data_page_query_7 = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new(start_date: one_week_before_starting_date, end_date: one_week_before_ending_date, dimensions: ["page"], row_limit: "5000", start_row: "0")
      
      two_week_before_ending_date = gscDate.to_date.strftime("%Y-%m-%d")
      two_week_before_starting_date = (gscDate.to_date - 14.days).strftime("%Y-%m-%d")
      data_page_query_14 = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new(start_date: two_week_before_starting_date, end_date: two_week_before_ending_date, dimensions: ["page"], row_limit: "5000", start_row: "0")
      
      four_week_before_ending_date = gscDate.to_date.strftime("%Y-%m-%d")
      four_week_before_starting_date = (gscDate.to_date - 30.days).strftime("%Y-%m-%d")
      data_page_query_30 = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new(start_date: four_week_before_starting_date, end_date: four_week_before_ending_date, dimensions: ["page"], row_limit: "5000", start_row: "0")
      
      results_page_query_7 = service.query_search_analytics("#{shop.google_website}", data_page_query_7)
      results_page_query_30 = service.query_search_analytics("#{shop.google_website}", data_page_query_30)
      results_page_query_14 = service.query_search_analytics("#{shop.google_website}", data_page_query_14)
      
      
      
      if results_page_query_7.rows != nil
        results_page_query_7.rows.each do |row|
          if testing_page_urls_for_seven_fourteen_and_thirty.include? row["keys"].first
            SearchConsole::SaveSevenDayBeforeFinalTestDataWorker.perform_async(shop.id, row)
          end
        end
      end
      if results_page_query_30.rows != nil
        results_page_query_30.rows.each do |row|
          if testing_page_urls_for_seven_fourteen_and_thirty.include? row["keys"].first
            SearchConsole::SaveThirtyDayBeforeFinalTestDataWorker.perform_async(shop.id, row)
          end
        end
      end
      if results_page_query_14.rows != nil
        results_page_query_14.rows.each do |row|
          if testing_page_urls_for_seven_fourteen_and_thirty.include? row["keys"].first
            SearchConsole::SaveFourteenDayBeforeFinalTestDataWorker.perform_async(shop.id, row)
          end
        end
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
