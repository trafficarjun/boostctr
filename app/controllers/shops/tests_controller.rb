class Shops::TestsController < ApplicationController
  def index
    @shop = Shop.find_by slug: params[:shop_id]
    @tests = @shop.tests
  end
end