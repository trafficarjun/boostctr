

task boostctr: :environment do
  shops = Shop.where(subscribed: true)
  gscDate = Time.current.to_date - 3.days
  shops.each do |shop|
    should_i_get_seven_fourteen_thirty_data = false
    should_i_get_seven_data_after = false
    should_i_get_fourteen_data_after = false
    should_i_get_thirty_data_after = false
    testing_page_urls_for_seven_fourteen_and_thirty = []
    testing_page_urls_for_seven_after = []
    testing_page_urls_for_fourteen_after = []
    testing_page_urls_for_thirty_after = []
    tests = shop.tests
    tests.each do |test|
      if !test.is_test_over
        #get 14 days before and 30 days before if 10TH created test IS 13th TODAY. 
        if test.four_week_before_updated == false && test.starting_date == gscDate
          #SearchConsole::GetFourteenAndThirtyForTestWorker.perform_async(@shop.id, @page.id, @test.id)
          should_i_get_seven_fourteen_thirty_data = true
          testing_page_urls_for_seven_fourteen_and_thirty << test.page.url
        end
        
        if test.one_week_after_updated == false && test.one_week_after_ending_date + 1.days == gscDate
          should_i_get_seven_data_after = true
          testing_page_urls_for_seven_after << test.page.url
        end
        
        if test.two_week_after_updated == false && test.two_week_after_ending_date + 1.days == gscDate
          should_i_get_fourteen_data_after = true
          testing_page_urls_for_fourteen_after << test.page.url
        end
        
        if test.four_week_after_updated == false && test.four_week_after_ending_date + 1.days == gscDate
          should_i_get_thirty_data_after = true
          testing_page_urls_for_thirty_after << test.page.url
        end
      end
    end
    if should_i_get_seven_fourteen_thirty_data && shop.google_website
      SearchConsole::GetSevenFourteenAndThirtyForTestWorker.perform_async(shop.id, testing_page_urls_for_seven_fourteen_and_thirty, gscDate)
    end
    if should_i_get_fourteen_data_after && shop.google_website
      SearchConsole::GetSevenDayAfterTestWorker.perform_async(shop.id, testing_page_urls_for_seven_after, gscDate)
    end
    if should_i_get_fourteen_data_after && shop.google_website
      SearchConsole::GetFourteenDayAfterTestWorker.perform_async(shop.id, testing_page_urls_for_fourteen_after, gscDate)
    end
    if should_i_get_thirty_data_after && shop.google_website
      SearchConsole::GetThirtyDayAfterTestWorker.perform_async(shop.id, testing_page_urls_for_thirty_after, gscDate)
    end
  end
end