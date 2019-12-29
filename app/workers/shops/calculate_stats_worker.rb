class Shops::CalculateStatsWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id)
    shop = Shop.find_by id: shop_id
    if shop
      shop.pages.each do |page|
        Pages::CalculateStatsWorker.perform_async(shop.id, page.id)
      end
    end
  end
end
