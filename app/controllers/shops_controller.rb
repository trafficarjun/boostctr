class ShopsController < ApplicationController
  
  def update
    @shop = Shop.find_by slug: params[:id]
    respond_to do |format|
      if params[:shop][:brand_name] != "" && @shop.update(shop_params)
        format.html { redirect_to root_path }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { redirect_to root_path  }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def shop_params
      params.require(:shop).permit(:brand_name)
    end
end
