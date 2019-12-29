class Shops::DeleteAllTablesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform()
    Click.destroy_all
    KeywordStat.destroy_all
    Keyword.destroy_all
    PageKeywordStat.destroy_all
    PageKeyword.destroy_all
    PageStat.destroy_all
    Page.destroy_all
    Plan.destroy_all
    ShopPlan.destroy_all
    Shop.destroy_all
    Stat.destroy_all
    Test.destroy_all    
  end
end
