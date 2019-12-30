class Shops::KeywordsController < ApplicationController
  
  def index
    @shop = Shop.find_by slug: params[:shop_id]
    if params[:sort] == "1_word"
      @viewing = "1 Word Keywords"
      @keywords = @shop.keywords.where(keyword_count: 1).paginate(page: params[:page], per_page: 50)
    elsif params[:sort] == "2_word"
      @viewing = "2 Word Keywords"
      @keywords = @shop.keywords.where(keyword_count: 2).paginate(page: params[:page], per_page: 50)
    elsif params[:sort] == "3_word"
      @viewing = "3 Word Keywords"
      @keywords = @shop.keywords.where(keyword_count: 3).paginate(page: params[:page], per_page: 50)
    elsif params[:sort] == "branded"
      @viewing = "Branded Keywords"
      @keywords = @shop.keywords.where(includes_brand_name: true).paginate(page: params[:page], per_page: 50)
    elsif params[:sort] == "nonbranded"
      @viewing = "Non Branded Keywords"
      @keywords = @shop.keywords.where(includes_brand_name: false).paginate(page: params[:page], per_page: 50)
    else
      @viewing = "4+ Word Keywords"
      @keywords = @shop.keywords.where(keyword_count: 4).paginate(page: params[:page], per_page: 50)
    end
    @tests = @shop.tests
  end
end