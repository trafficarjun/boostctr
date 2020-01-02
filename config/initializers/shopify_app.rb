ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  
  #dev 
  #config.api_key = Rails.application.credentials.shopify_dev_api_key
  #config.secret = Rails.application.credentials.shopify_dev_secret
  
  #prod
  config.api_key = ENV['shopify_prod_key']
  config.secret =ENV['shopify_prod_secret']
  
  config.old_secret = ""
  config.scope = "read_products, write_products, read_content, write_content" # Consult this page for more scope options:
                                 # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = false
  config.after_authenticate_job = false
  config.api_version = "2019-10"
  config.session_repository = Shop
  
  config.webhooks = [
    {topic: 'carts/update', address: 'https://example.com/webhooks/carts_update', format: 'json'},
  ]
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
