class Spree::Admin::SubscriptionsController < Spree::Admin::BaseController
  layout 'spree/layouts/admin'
  
  before_filter :get_subscription, only: [:edit, :update, :destroy]
  
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      flash[:success] = Spree.t('subscription has been successfully created.')
      redirect_to '/spree/admin/subscriptions'
    else
      render 'new'
    end
  end

  def edit
    render 'new'
  end

  def update
    if @subscription.update_attributes(subscription_params)
      flash[:success] = Spree.t('subscription has been successfully updated.')
      redirect_to '/spree/admin/subscriptions'
    else
      render 'new'
    end
  end
  
  def index
    @subscriptions = Subscription.select('id, quantity, subscription_type AS name, plan_id, plan_price AS price')
    @search = Subscription.new
  end

  def destroy
    @subscription.update_column(:deleted, true)
    flash[:success] = Spree.t('subscription has been successfully deleted.')
    redirect_to '/spree/admin/subscriptions'
  end
  
  protected

  def subscription_params
    params.require(:subscription).permit!
  end

  def get_subscription
    @subscription = Subscription.where(id: params[:id]).first
    redirect_to '/spree/admin/subscriptions' if @subscription.blank?
  end
  
end