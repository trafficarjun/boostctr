# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    myshopify_domain = ShopifyAPI::Shop.current.myshopify_domain
    domain = ShopifyAPI::Shop.current.domain
    email = ShopifyAPI::Shop.current.customer_email
    @shop = Shop.find_by shopify_domain: myshopify_domain
    @shop.update_email_domain(email, domain)
  end
end
