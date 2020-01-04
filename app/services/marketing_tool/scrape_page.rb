class MarketingTool::ScrapePage
  attr_reader :url
  
  def initialize(url)
    @url = url
  end
 
  def start
    begin
      response = HTTP.get(url)
    rescue => e
      raise e
    else
      if response != nil 
        code = response.code
        if code && code.to_s.start_with?('2')
          #write all the logic here for scraping relevant data
        end
      end
    end
  end

end