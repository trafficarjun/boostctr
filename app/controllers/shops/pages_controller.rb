class Shops::PagesController < ApplicationController
  
  def index
    @shop = Shop.find_by slug: params[:shop_id]
    if params[:sort] == "pages"
      @viewing = "Other pages"
      @insights = @shop.insights.where(shopify_page_type: "pages").paginate(page: params[:page], per_page: 50)
    elsif params[:sort] == "blogs"
      @viewing = "Blog pages"
      @insights = @shop.insights.where(shopify_page_type: "blogs").paginate(page: params[:page], per_page: 50)
    else
      @viewing = "Product + Collection Pages"
      @insights = @shop.insights.where(shopify_page_type: "products").or(@shop.insights.where(shopify_page_type: "products")).or(@shop.insights.where(shopify_page_type: "frontpage")).paginate(page: params[:page], per_page: 50)
    end
    @tests = @shop.tests
  end
  
  def show
    @shop = Shop.find_by slug: params[:shop_id]
    @page = @shop.pages.find_by slug: params[:id]
    @tests = @page.tests
    redirect_to new_shop_page_test_path(@shop, @page) if @page.tests.count == 0
  end
  
  def insights
    @shop = Shop.find_by slug: params[:shop_id]
    @tests = @shop.tests
    @clicks = @shop.clicks
    #Page.destroy_all
    #Keyword.destroy_all
    #Stat.destroy_all
    #KeywordStat.destroy_all
    #PageStat.destroy_all
    #Click.destroy_all
  end
end