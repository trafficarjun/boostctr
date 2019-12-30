require 'signet/oauth_2/client'
require 'google/api_client/client_secrets.rb'
require 'google/apis/webmasters_v3'

class SearchConsole::GetThirtyDayAfterTestWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, testing_page_urls, gscDate)
    shop = Shop.find_by id: shop_id
    if shop 
      service = Google::Apis::WebmastersV3::WebmastersService.new
      service.authorization = google_secret(shop).to_authorization
      service.authorization.refresh!
      
      endTime = gscDate.to_date.strftime("%Y-%m-%d")
      startTime = (gscDate.to_date - 30.days).strftime("%Y-%m-%d")
      data = Google::Apis::WebmastersV3::SearchAnalyticsQueryRequest.new(start_date: startTime, end_date: endTime, dimensions: ["page"], row_limit: "5000", start_row: "0")
      
      results = service.query_search_analytics("#{shop.google_website}", data)
      
      if results.rows != nil
        results.rows.each do |row|
          if testing_page_urls.include? row.keys.first
            SearchConsole::SaveThirtyDayAfterFinalTestDataWorker.perform_async(shop.id, row)
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
