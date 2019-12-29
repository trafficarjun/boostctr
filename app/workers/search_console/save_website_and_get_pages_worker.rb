class SearchConsole::SaveWebsiteAndGetPagesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, website)
    shop = Shop.find_by id: shop_id
    binding.pry
    if shop
      SearchConsole::GetPagesFirstTimeWorker.perform_async(shop.id)
    end
  end
end
