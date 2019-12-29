class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  include Sluggable
  sluggable_column :shopify_domain
  
  has_many :pages, dependent: :destroy
  has_many :tests, -> { order("created_at DESC")} , dependent: :destroy
  
  def api_version
    ShopifyApp.configuration.api_version
  end
  
  def update_email_domain(email, domain)
    if self.email != email || self.domain != domain
      self.update(email: email, domain: domain) 
    end
  end
  
  def free_plan
    if !Plan.any?
      Plan.create(name: "Free", price: "0")
      Plan.create(name: "Growth", price: "29")
      Plan.create(name: "Business", price: "79")
      Plan.create(name: "Agency", price: "199")
    end
    ShopPlan.create(shop_id: self.id, plan_id: Plan.first.id, created_at: Date.today)
    Shops::CheckPlanWorker.perform_in(15.days.from_now, self.id)
  end
end
