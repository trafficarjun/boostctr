# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    myshopify_domain = ShopifyAPI::Shop.current.myshopify_domain
    domain = ShopifyAPI::Shop.current.domain
    email = ShopifyAPI::Shop.current.customer_email
    @shop = Shop.find_by shopify_domain: myshopify_domain
    @shop.update_email_domain(email, domain)
    
    AppMailer.send_shop_sign_in(@shop.shopify_domain).deliver_later
    @pages = @shop.pages.paginate(page: params[:page], per_page: 50)
    @tests = @shop.tests.first(10)
  end
end
