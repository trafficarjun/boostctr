class Pages::DeletePagesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, page_id)
    shop = Shop.find_by id: shop_id
    page = shop.pages.find_by id: page_id
    if shop && page
      page.destroy
    end
  end
end
