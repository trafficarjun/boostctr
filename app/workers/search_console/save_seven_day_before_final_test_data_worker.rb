class SearchConsole::SaveSevenDayBeforeFinalTestDataWorker
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
    test.update(one_week_before_clicks: clicks, one_week_before_impressions: impressions, 
      one_week_before_ctr: ctr, one_week_before_position: position, one_week_before_updated: true) if test
  end
end