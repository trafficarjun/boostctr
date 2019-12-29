class SessionsController < AuthenticatedController
  
  def googleAuth
    myshopify_domain = ShopifyAPI::Shop.current.myshopify_domain
    shop = Shop.find_by shopify_domain: myshopify_domain
    access_token = request.env["omniauth.auth"]
    shop.google_token = access_token.credentials.token
    refresh_token = access_token.credentials.refresh_token
    shop.google_refresh_token = refresh_token if refresh_token.present?
    shop.save
    binding.pry
    redirect_to select_website_path
  end
end