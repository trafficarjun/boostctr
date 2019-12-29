class Pages::CalculateStatsWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id, page_id)
    shop = Shop.find_by id: shop_id
    page = shop.pages.find_by id: page_id
    if shop && page
      if page.stats
        clicks, impressions = page.stats.map{|s| [s.clicks.to_i, s.impressions.to_i]}.transpose.map(&:sum)
        ctr = (clicks.to_f / impressions.to_f).round(4) * 100
        page.insight.destroy if page.insight
        Insight.create(shop_id: shop.id, page_id: page.id, clicks: clicks, impressions: impressions, ctr: ctr, shopify_page_type: page.shopify_page_type)
      end
    end
  end
end
