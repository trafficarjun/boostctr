class SeoScoreController < ApplicationController
  def index
  end
  
  def results
    @keyword = params[:focus_keyword]
    @url = params[:page_url]
    if @keyword && @url && url_is_valid?(@url)
      MarketingTool::ScrapePageWorker.perform_async(@url)
    end
    @score = 0
  end
  
  private
  def url_is_valid?(url)
    url.include? "products"
  end
end
