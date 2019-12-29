class Shops::CheckPlanWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id)
    shop = Shop.find_by id: shop_id
    if shop
      current_shop_plan = shop.shop_plans.last
      if current_shop_plan.plan.name == "Free"
        shop.update(subscribed: false) if shop.subscribed == true
      end
    end
  end
end
