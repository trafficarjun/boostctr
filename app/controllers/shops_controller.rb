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
  
  def needs_seo_help
    @shop = Shop.find_by slug: params[:shop_id]
    @shop.update(needs_help: false)
    AppMailer.send_shop_needs_help(@shop.shopify_domain).deliver_later
    redirect_to insights_shop_pages_path(@shop), notice: "I'll be in touch with you via email (arjunrajkumars@gmail.com) regardign this ASAP. Thanks! - Arjun"
  end

  private
    def shop_params
      params.require(:shop).permit(:brand_name)
    end
end
