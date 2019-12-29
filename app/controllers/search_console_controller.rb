require 'google/api_client/client_secrets.rb'
require 'google/apis/webmasters_v3'

class SearchConsoleController < AuthenticatedController
  #before_action :set_shop
  #before_action :load_current_recurring_charge
  
  def select_website
    myshopify_domain = ShopifyAPI::Shop.current.myshopify_domain
    @shop = Shop.find_by shopify_domain: myshopify_domain
    begin
      service = Google::Apis::WebmastersV3::WebmastersService.new
      service.authorization = google_secret(@shop).to_authorization 
      service.authorization.refresh! 
    rescue
      service = nil
    end
    @error = ""
    if service && service.list_sites
      begin
        @all_websites = service.list_sites
      rescue Google::Apis::ClientError => e
        raise e
        @error = e.message
      else
        redirect_to root_path, notice: "Please select an account which has access to your Google Search Console" if @all_websites.site_entry == nil
      end
    else
      redirect_to root_path, notice: "Please select an account which has access to your Google Search Console"
    end
  end
  
  def downloading_data
    myshopify_domain = ShopifyAPI::Shop.current.myshopify_domain
    @shop = Shop.find_by shopify_domain: myshopify_domain
    if params[:selected_website] == ""
      redirect_to select_website_path, notice: "Please select a website from Google Search Console to continue."
    else
      selected_website = params[:selected_website]
      if selected_website
        if selected_website.include? "myshopify.com"
          @shop.update(google_website: selected_website, shopify_domain_google_website_match: true)
        else
          @shop.update(google_website: selected_website, shopify_domain_google_website_match: false)
        end
        SearchConsole::GetPagesFirstTimeWorker.perform_async(@shop.id)
      end
      redirect_to root_path
    end
  end
  

  private
  
  def google_secret(shop)
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => @shop.google_token,
          "refresh_token" => @shop.google_refresh_token,
          "client_id" => Rails.application.credentials.google_key,
          "client_secret" => Rails.application.credentials.google_secret
        }
      })
  end
end