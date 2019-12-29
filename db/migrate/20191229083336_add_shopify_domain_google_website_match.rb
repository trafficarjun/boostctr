class AddShopifyDomainGoogleWebsiteMatch < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :shopify_domain_google_website_match, :boolean, default: true
  end
end
