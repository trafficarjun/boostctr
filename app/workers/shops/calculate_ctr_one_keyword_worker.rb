class Shops::CalculateCtrOneKeywordWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(shop_id)
    shop = Shop.find_by id: shop_id
    if shop
      keywords = shop.keywords.where(keyword_count: 1, includes_brand_name: false)
      position_1_sum_of_ctrs = 0
      counter_1 = 0
      position_2_sum_of_ctrs = 0
      counter_2 = 0
      position_3_sum_of_ctrs = 0
      counter_3 = 0
      position_4_sum_of_ctrs = 0
      counter_4 = 0
      position_5_sum_of_ctrs = 0
      counter_5 = 0
      position_6_sum_of_ctrs = 0
      counter_6 = 0
      position_7_sum_of_ctrs = 0
      counter_7 = 0
      position_8_sum_of_ctrs = 0
      counter_8 = 0
      position_9_sum_of_ctrs = 0
      counter_9 = 0
      position_10_sum_of_ctrs = 0
      counter_10 = 0
      keywords.each do |keyword|
        #calcualte avg ctr for each postion which is the sum of all the ctrs in that postion divided by the total number of CTRs
        keyword_stat_postion_1 = keyword.stats.find_by position: "1"
        if keyword_stat_postion_1 && keyword_stat_postion_1.ctr
          counter_1 += 1
          position_1_sum_of_ctrs = position_1_sum_of_ctrs + keyword_stat_postion_1.ctr.to_i
        end
        keyword_stat_postion_2 = keyword.stats.find_by position: "2"
        if keyword_stat_postion_2 && keyword_stat_postion_2.ctr
          counter_2 += 1
          position_2_sum_of_ctrs = position_2_sum_of_ctrs + keyword_stat_postion_2.ctr.to_i
        end
        keyword_stat_postion_3 = keyword.stats.find_by position: "3"
        if keyword_stat_postion_3 && keyword_stat_postion_3.ctr
          counter_3 += 1
          position_3_sum_of_ctrs = position_3_sum_of_ctrs + keyword_stat_postion_3.ctr.to_i
        end
        keyword_stat_postion_4 = keyword.stats.find_by position: "4"
        if keyword_stat_postion_4 && keyword_stat_postion_4.ctr
          counter_4 += 1
          position_4_sum_of_ctrs = position_4_sum_of_ctrs + keyword_stat_postion_4.ctr.to_i
        end
        keyword_stat_postion_5 = keyword.stats.find_by position: "5"
        if keyword_stat_postion_5 && keyword_stat_postion_5.ctr
          counter_5 += 1
          position_5_sum_of_ctrs = position_5_sum_of_ctrs + keyword_stat_postion_5.ctr.to_i
        end
        keyword_stat_postion_6 = keyword.stats.find_by position: "6"
        if keyword_stat_postion_6 && keyword_stat_postion_6.ctr
          counter_6 += 1
          position_6_sum_of_ctrs = position_6_sum_of_ctrs + keyword_stat_postion_6.ctr.to_i
        end
        keyword_stat_postion_7 = keyword.stats.find_by position: "7"
        if keyword_stat_postion_7 && keyword_stat_postion_7.ctr
          counter_7 += 1
          position_7_sum_of_ctrs = position_7_sum_of_ctrs + keyword_stat_postion_7.ctr.to_i
        end
        keyword_stat_postion_8 = keyword.stats.find_by position: "8"
        if keyword_stat_postion_8 && keyword_stat_postion_8.ctr
          counter_8 += 1
          position_8_sum_of_ctrs = position_8_sum_of_ctrs + keyword_stat_postion_8.ctr.to_i
        end
        keyword_stat_postion_9 = keyword.stats.find_by position: "9"
        if keyword_stat_postion_9 && keyword_stat_postion_9.ctr
          counter_9 += 1
          position_9_sum_of_ctrs = position_9_sum_of_ctrs + keyword_stat_postion_9.ctr.to_i
        end
        keyword_stat_postion_10 = keyword.stats.find_by position: "10"
        if keyword_stat_postion_10 && keyword_stat_postion_10.ctr
          counter_10 += 1
          position_10_sum_of_ctrs = position_10_sum_of_ctrs + keyword_stat_postion_10.ctr.to_i
        end
      end
      
      position_1_average_ctr_for_keywords = (position_1_sum_of_ctrs.to_f / counter_1.to_f).round(2) if counter_1 > 0
      position_2_average_ctr_for_keywords = (position_2_sum_of_ctrs.to_f / counter_2.to_f).round(2) if counter_2 > 0
      position_3_average_ctr_for_keywords = (position_3_sum_of_ctrs.to_f / counter_3.to_f).round(2) if counter_3 > 0
      position_4_average_ctr_for_keywords = (position_4_sum_of_ctrs.to_f / counter_4.to_f).round(2) if counter_4 > 0
      position_5_average_ctr_for_keywords = (position_5_sum_of_ctrs.to_f / counter_5.to_f).round(2) if counter_5 > 0
      position_6_average_ctr_for_keywords = (position_6_sum_of_ctrs.to_f / counter_6.to_f).round(2) if counter_6 > 0
      position_7_average_ctr_for_keywords = (position_7_sum_of_ctrs.to_f / counter_7.to_f).round(2) if counter_7 > 0
      position_8_average_ctr_for_keywords = (position_8_sum_of_ctrs.to_f / counter_8.to_f).round(2) if counter_8 > 0
      position_9_average_ctr_for_keywords = (position_9_sum_of_ctrs.to_f / counter_9.to_f).round(2) if counter_9 > 0
      position_10_average_ctr_for_keywords = (position_10_sum_of_ctrs.to_f / counter_10.to_f).round(2) if counter_10 > 0
      
      old_ctr_at_1 = shop.clicks.where(ctr_type: "1keyword", rank: 1)
      old_ctr_at_2 = shop.clicks.where(ctr_type: "1keyword", rank: 2)
      old_ctr_at_3 = shop.clicks.where(ctr_type: "1keyword", rank: 3)
      old_ctr_at_4 = shop.clicks.where(ctr_type: "1keyword", rank: 4)
      old_ctr_at_5 = shop.clicks.where(ctr_type: "1keyword", rank: 5)
      old_ctr_at_6 = shop.clicks.where(ctr_type: "1keyword", rank: 6)
      old_ctr_at_7 = shop.clicks.where(ctr_type: "1keyword", rank: 7)
      old_ctr_at_8 = shop.clicks.where(ctr_type: "1keyword", rank: 8)
      old_ctr_at_9 = shop.clicks.where(ctr_type: "1keyword", rank: 9)
      old_ctr_at_10 = shop.clicks.where(ctr_type: "1keyword", rank: 10)
      
      #update the average ctr for the shop
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 1, ctr: position_1_average_ctr_for_keywords) if !old_ctr_at_1.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 2, ctr: position_2_average_ctr_for_keywords) if !old_ctr_at_2.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 3, ctr: position_3_average_ctr_for_keywords) if !old_ctr_at_3.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 4, ctr: position_4_average_ctr_for_keywords) if !old_ctr_at_4.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 5, ctr: position_5_average_ctr_for_keywords) if !old_ctr_at_5.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 6, ctr: position_6_average_ctr_for_keywords) if !old_ctr_at_6.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 7, ctr: position_7_average_ctr_for_keywords) if !old_ctr_at_7.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 8, ctr: position_8_average_ctr_for_keywords) if !old_ctr_at_8.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 9, ctr: position_9_average_ctr_for_keywords) if !old_ctr_at_9.any?
      Click.create(shop_id: shop.id, ctr_type: "1keyword", rank: 10, ctr: position_10_average_ctr_for_keywords) if !old_ctr_at_10.any?
    end
  end
end
