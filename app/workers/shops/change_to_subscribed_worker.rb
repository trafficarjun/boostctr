class Shops::ChangeToSubscribedWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, bool)
    shop = Shop.find_by id: shop_id
    shop.update(subscribed: bool) 
  end
end
