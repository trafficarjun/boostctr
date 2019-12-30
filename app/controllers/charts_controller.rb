class ChartsController < ApplicationController
  def branded
    @shop = Shop.find_by id: params[:shop_id]
    @branded_ctrs = @shop.clicks.where(ctr_type: "branded")
    @non_branded_ctrs = @shop.clicks.where(ctr_type: "non_branded")
    
    result = []
    res = {}
    res[:name] = "Branded Keywords"
    res[:data] = @branded_ctrs.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "Non Branded Keywords"
    res[:data] = @non_branded_ctrs.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    render json: result.chart_json
  end
  
  def longtail
    @shop = Shop.find_by id: params[:shop_id]
    @one_word = @shop.clicks.where(ctr_type: "1keyword")
    @two_word = @shop.clicks.where(ctr_type: "2keywords")
    @three_word = @shop.clicks.where(ctr_type: "3keywords")
    @four_word = @shop.clicks.where(ctr_type: "4keywords")
    
    result = []
    res = {}
    res[:name] = "1 word"
    res[:data] = @one_word.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "2 word"
    res[:data] = @two_word.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "3 word"
    res[:data] = @three_word.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "4+ word keywords"
    res[:data] = @four_word.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    render json: result.chart_json
  end
  
  def transactional
    @shop = Shop.find_by id: params[:shop_id]
    @all = @shop.clicks.where(ctr_type: "all")
    @blogs = @shop.clicks.where(ctr_type: "blogs")
    @pages = @shop.clicks.where(ctr_type: "pages")
    @products = @shop.clicks.where(ctr_type: "products")

    result = []
    res = {}
    res[:name] = "All (Site wide CTR)"
    res[:data] = @all.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "Product + Collection Pages (Transactional)"
    res[:data] = @products.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "Blogs (Informational)"
    res[:data] = @blogs.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    
    res = {}
    res[:name] = "Others (Informational)"
    res[:data] = @pages.map{|t| [t.rank, t.ctr]} 
    10.times do 
      if res[:data].any? && res[:data].first.second == 0
        res[:data].shift
      end
    end
    result.push << res
    render json: result.chart_json
  end
end