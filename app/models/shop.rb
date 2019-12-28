class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  def api_version
    ShopifyApp.configuration.api_version
  end
  
  def update_email_domain(email, domain)
    if self.email != email || self.domain != domain
      self.update(email: email, domain: domain) 
    end
  end
  
  include Sluggable
  sluggable_column :shopify_domain
end
