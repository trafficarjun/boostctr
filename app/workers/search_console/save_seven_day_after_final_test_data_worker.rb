class SearchConsole::SaveSevenDayAfterFinalTestDataWorker
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
    
    if test.one_week_before_clicks.to_i != 0 && clicks.to_i != 0
      if test.one_week_before_clicks.to_i < clicks.to_i
        results_clicks = ((test.one_week_before_clicks.to_i - clicks).abs.to_f/test.one_week_before_clicks.to_f) * 100
        one_week_result_clicks_greater = true
      else
        results_clicks = ((test.one_week_before_clicks.to_i - clicks).abs.to_f/test.one_week_before_clicks.to_f) * 100
        one_week_result_clicks_greater = false
      end
    elsif test.one_week_before_clicks.to_i == 0 && clicks.to_i != 0
      results_clicks = "INF"
      one_week_result_clicks_greater = true
    elsif test.one_week_before_clicks.to_i != 0 && clicks.to_i == 0
      results_clicks = ((test.one_week_before_clicks.to_i - clicks).abs.to_f/test.one_week_before_clicks.to_f) * 100
      one_week_result_clicks_greater = false
    elsif test.one_week_before_clicks.to_i == 0 && clicks.to_i == 0
      results_clicks = "NAN"
      one_week_result_clicks_greater = false
    end
    
    if test.one_week_before_impressions.to_i != 0 && impressions.to_i != 0
      if test.one_week_before_impressions.to_i < impressions.to_i
        results_impressions = ((test.one_week_before_impressions.to_i - impressions).abs.to_f/test.one_week_before_impressions.to_f) * 100
        one_week_result_impressions_greater = true
      else
        results_impressions = ((test.one_week_before_impressions.to_i - impressions).abs.to_f/test.one_week_before_impressions.to_f) * 100
        one_week_result_impressions_greater = false
      end
    elsif test.one_week_before_impressions.to_i == 0 && impressions.to_i != 0
      results_impressions = "INF"
      one_week_result_impressions_greater = true
    elsif test.one_week_before_impressions.to_i != 0 && impressions.to_i == 0
      results_impressions = ((test.one_week_before_impressions.to_i - impressions).abs.to_f/test.one_week_before_impressions.to_f) * 100
      one_week_result_impressions_greater = false
    elsif test.one_week_before_impressions.to_i == 0 && impressions.to_i == 0
      results_impressions = "NAN"
      one_week_result_impressions_greater = false
    end
    
    if test.one_week_before_ctr.to_i != 0 && ctr.to_i != 0
      if test.one_week_before_ctr.to_i < ctr.to_i
        results_ctr = ((test.one_week_before_ctr.to_i - ctr).abs.to_f/test.one_week_before_ctr.to_f) * 100
        one_week_result_ctr_greater = true
      else
        results_ctr = ((test.one_week_before_ctr.to_i - ctr).abs.to_f/test.one_week_before_ctr.to_f) * 100
        one_week_result_ctr_greater = false
      end
    elsif test.one_week_before_ctr.to_i == 0 && ctr.to_i != 0
      results_ctr = "INF"
      one_week_result_ctr_greater = true
    elsif test.one_week_before_ctr.to_i != 0 && ctr.to_i == 0
      results_ctr = ((test.one_week_before_ctr.to_i - ctr).abs.to_f/test.one_week_before_ctr.to_f) * 100
      one_week_result_ctr_greater = false
    elsif test.one_week_before_ctr.to_i == 0 && ctr.to_i == 0
      results_ctr = "NAN"
      one_week_result_ctr_greater = false
    end
    
    if test.one_week_before_position.to_i != 0 && position.to_i != 0
      if test.one_week_before_position.to_i < position.to_i
        results_position = ((test.one_week_before_position.to_i - position).abs.to_f/test.one_week_before_position.to_f) * 100
        one_week_result_position_greater = true
      else
        results_position = ((test.one_week_before_position.to_i - position).abs.to_f/test.one_week_before_position.to_f) * 100
        one_week_result_position_greater = false
      end
    elsif test.one_week_before_position.to_i == 0 && position.to_i != 0
      results_position = "INF"
      one_week_result_position_greater = true
    elsif test.one_week_before_position.to_i != 0 && position.to_i == 0
      results_position = ((test.one_week_before_position.to_i - position).abs.to_f/test.one_week_before_position.to_f) * 100
      one_week_result_position_greater = false
    elsif test.one_week_before_position.to_i == 0 && position.to_i == 0
      results_position = "NAN"
      one_week_result_position_greater = false
    end
    
    
    test.update(one_week_after_clicks: clicks, one_week_after_impressions: impressions, 
      one_week_after_ctr: ctr, one_week_after_position: position, one_week_after_updated: true,
      one_week_result_clicks: results_clicks, one_week_result_impressions: results_impressions, one_week_result_ctr: results_ctr, one_week_result_position: results_position,
      one_week_result_clicks_greater: one_week_result_clicks_greater, one_week_result_impressions_greater: one_week_result_ctr_greater, one_week_result_ctr_greater: one_week_result_ctr_greater, one_week_result_position_greater: one_week_result_position_greater) if test
  end
end