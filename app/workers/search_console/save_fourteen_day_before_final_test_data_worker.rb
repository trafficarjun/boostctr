class SearchConsole::SaveFourteenDayBeforeFinalTestDataWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false
  
  def perform(shop_id, row)
    ctr = (row["ctr"] * 100).round(2)
    position = row["position"].round(2)
    clicks = row["clicks"]
    impressions = row["impressions"]
    shop = Shop.find_by id: shop_id
    page = shop.pages.find_by(url: row["keys"].first) 
    test = page.tests.first
    test.update(two_week_before_clicks: clicks, two_week_before_impressions: impressions, 
      two_week_before_ctr: ctr, two_week_before_position: position, two_week_before_updated: true) if test
  end
end
