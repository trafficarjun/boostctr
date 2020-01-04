class MarketingTool::ScrapePageWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'default', :retry => false

  def perform(url)
    MarketingTool::ScrapePage.new(url).start
  end
end
