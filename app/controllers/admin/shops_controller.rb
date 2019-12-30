class Admin::ShopsController < ApplicationController
  
  #before_action :require_admin

  def index
    @shops = Shop.all
  end
  
  def show 
    @shop = Shop.find_by slug: params[:id]
    @pages = @shop.pages.paginate(page: params[:page], per_page: 50)
    @tests = @shop.tests.first(50)
  end
  
  def delete_everything
    Shops::DeleteAllTablesWorker.perform_async()
    redirect_to admin_shops_path
  end
  
  def reset_gsc
    @shop = Shop.find_by slug: params[:shop_id]
    Shops::DeleteAllPagesWorker.perform_async(@shop.id)
    SearchConsole::GetPagesFirstTimeWorker.perform_in(5.minutes, @shop.id)
    redirect_to admin_shops_path
  end
  
  def delete_gsc
    @shop = Shop.find_by slug: params[:shop_id]
    @shop.update(google_website: nil, google_token: nil, google_refresh_token: nil, expiresat: nil)
    redirect_to admin_shops_path
  end
  
  def destroy
    @shop = Shop.find_by slug: params[:id]
    @shop.destroy
    redirect_to shop_plans_path
  end
  
  private
  def require_admin
    if !current_user.admin?
      flash[:error] = "You are not authorised to do that"
      redirect_to root_path 
    end
  end
end