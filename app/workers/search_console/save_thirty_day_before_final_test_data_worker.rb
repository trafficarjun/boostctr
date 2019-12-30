class SearchConsole::SaveThirtyDayBeforeFinalTestDataWorker
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
    test.update(four_week_before_clicks: clicks, four_week_before_impressions: impressions, 
      four_week_before_ctr: ctr, four_week_before_position: position, four_week_before_updated: true) if test
  end
end