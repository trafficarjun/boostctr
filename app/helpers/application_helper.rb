module ApplicationHelper
  def fix_time(dt)
    if dt != nil
      dt.strftime("%b %d, %Y ")
    end
  end
  
  def trail_days(shop)
    if shop.plans.last.name == "Free"
      if (shop.created_at + 14.days) > Time.current.to_date 
        ((shop.created_at.to_date + 14.days) - Time.current.to_date).to_i 
      end
    end
  end
  
  def calculate_percentage_diff(stat)
    clicks = stat.clicks.to_i
    expected_clicks = stat.expected_clicks.to_i
    if clicks != 0
      diff = (((clicks - expected_clicks).abs.to_f / clicks.to_f) * 100).to_i
    else
      diff = 0
    end
    string = diff.to_s + "%"
  end
end
