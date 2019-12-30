class Shops::RecurringApplicationChargesController < AuthenticatedController
  before_action :set_shop
  before_action :load_current_recurring_charge

  def show
    @shop = Shop.find_by slug: params[:shop_id]
    @pages = @shop.pages
    #redirect_to root_path if @pages.count == 0
    @plan = @shop.shop_plans.last.plan
    @end_date = @shop.shop_plans.last.created_at + 14.days
  end

  def create
    @recurring_application_charge.try!(:cancel)
    @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(name: params[:name], price: params[:price])
    @recurring_application_charge.test = true
    @recurring_application_charge.return_url = callback_shop_recurring_application_charge_url
    if @recurring_application_charge.save
      flash[:success] = "Thank you! We have updated the plan."
      fullpage_redirect_to @recurring_application_charge.confirmation_url
    else
      flash[:danger] = @recurring_application_charge.errors.full_messages.first.to_s.capitalize
      redirect_to correct_path(@recurring_application_charge)
    end
  end

  def customize
    @recurring_application_charge.customize(params[:recurring_application_charge])
    fullpage_redirect_to @recurring_application_charge.update_capped_amount_url
  end

  def callback
    @shop = Shop.find_by slug: params[:shop_id]
    @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(params[:charge_id])
    if @recurring_application_charge.status == 'accepted'
      @recurring_application_charge.activate
      plan = Plan.find_by name: @recurring_application_charge.name
      ShopPlan.create(shop_id: @shop.id, plan_id: plan.id)
      Shops::ChangeToSubscribedWorker.perform_in(5.seconds.from_now, @shop.id, true)
    end
    redirect_to_correct_path(@recurring_application_charge)
  end
  
  def destroy
    @recurring_application_charge.cancel
    ShopPlan.create(shop_id: @shop.id, plan_id: Plan.first.id, created_at: DateTime.now.days_ago(720))
    Shops::ChangeToSubscribedWorker.perform_in(5.seconds.from_now, @shop.id, false)
    flash[:success] = "Recurring application charge was cancelled successfully"
    redirect_to_correct_path(@recurring_application_charge)
  end

  private
  
  def set_shop
    @shop = Shop.find_by slug: params[:shop_id]
  end
  
  def load_current_recurring_charge
    @recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.current
  end

  def recurring_application_charge_params
    params.require(:recurring_application_charge).permit(
      :name,
      :capped_amount,
      :terms,
      :trial_days
    )
  end

  def redirect_to_correct_path(recurring_application_charge)
    if recurring_application_charge.try(:capped_amount)
      redirect_to usage_charge_path
    else
      redirect_to shop_recurring_application_charge_path
    end
  end
end