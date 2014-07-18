class MySubscriptionsController < ApplicationController
  require 'braintree'
  include ApplicationHelper
  include MySubscriptionsHelper
  #before_filter :get_subscription, :only => [:edit, :update, :show]
  before_action :prepare_subscription, only: [:show, :cancel]
  before_action :get_subscription, only: [:edit, :pause, :prompt_confirmation_modal, :block]

  # This will list all the active subscriptions in the list.
  def index
    @my_subscriptions = current_user.active_subscriptions
  end

=begin
  before this functionality was implemented to show a modal listing the subscriptions opting for
  cancellation.now the cancelation has moved to update subscription page ,hence commenting out this
  section.

  #this action will white list only the eligible subscriptions those can be cancelled.
  def prompt_cancelation
    @my_subscriptions = current_user.active_subscriptions
  end
=end

  #below action will show the required modal window(pause, resume) or will update the subscription.
  def prompt_confirmation_modal
    @target_action = params[:target]
    @sub_id = params[:id]
    @controller = params[:controller]
    @method = params[:method]

    #Enable this code to have the conditional pause/resume functionality.
    #@locked_order =  @my_subscription.get_under_process_orders_number if is_cancel_or_pause?(@target_action)
  end

  #this action will show the  cancellation form to user using which the subscription will be cancelled.
  def cancel
    @confirmation_header = "confirm cancellation"
    @confirmation_body = "Are you Sure to cancel this subscription?"
    @cancel = "No, Thank you"
    @submit = "Confirm cancellation"
  end

  #below action will perform subscription cancellation & redirect to profile page with proper notification.
  def submit_cancel
    get_subscription
    is_cancelled = @my_subscription.cancel_or_pause_subscription("canceled") #unless @my_subscription.is_under_process?
    flash[:sub_cancelled] = "Subscription has been canceled Successfully." if is_cancelled
    redirect_to main_app.profile_users_path and return
  end

  # Below action will perform subscription pause and redirect to profile/account page with proper notification.
  def pause
    @my_subscription.cancel_or_pause_subscription("paused")
    type = @my_subscription.subscription.subscription_type
    date = @my_subscription.orders.where(state: 'paused').first.delivery_date.strftime("%B %d, %Y")
    flash[:sub_cancelled] = " #{type} #{date} has been paused Successfully."
    redirect_to main_app.profile_users_path and return
  end

  # Below action will perform subscription resume and will return proper notifications on success & failure cases.
  def resume
    card_id = params[:card_id]
    subscription = UserSubscription.get_my_paused_subscription(current_user, params[:id])
    resumed_sub = subscription.resume_subscription(card_id) if subscription.present?

    if resumed_sub.present?
      result = { key: 'success', message: "#{resumed_sub} has been resumed Successfully. please wait..." }
    else
     result = { key: 'error', message: "Sorry, you are not authorized for this subscription." }
    end

    render json: result.to_json
  end

  #Action will block a subscription because of insufficient fund or invalid creditcard details.
  def block
    #first pause those subscriptions as those will be reactivated once customer alters his payment details.
    @my_subscription.cancel_or_pause_subscription("paused")
    #now, mark those subscription blocked.
    @my_subscription.block_subscription

    flash[:sub_cancelled] = "#{@my_subscription.id}  subscription has been paused "
    redirect_to main_app.profile_users_path and return
  end

  #Action will unblock a subscription after proper payment has been done for the same.
  def unblock
    card_id = params[:card_id]
    subscription = UserSubscription.get_my_paused_subscription(current_user, params[:id])

    if subscription.present?
      unblocked_subscription = subscription.resume_subscription(card_id)
      subscription.unblock_subscription
    end

    if unblocked_subscription.present?
      result = { key: "success", message: "#{unblocked_subscription} has been unblocked Successfully. Please wait..."}
    else
      result = { key: 'error', message: "Sorry, you are not authorized for this subscription." }
    end
    render json: result.to_json
  end

  # Action will fetch the subscriptions final amount(considering the coupon code(valid/invalid/without code)) and
  #return necessary message.
  def fetch_subscriptions_payment
    subscription  = UserSubscription.where(id: params[:subscription_id]).first

    if subscription.present?
      message = subscription.get_payment_message
      #we need the payment details for the paused orders hence passing "paused" to this function.
      card_id = subscription.get_card("paused")
    else
      flash[:error] = "Sorry, you are not authorized for this subscription."
      redirect_to main_app.profile_users_path and return
    end

    render json: {message: message, card_id: card_id}.to_json
  end

  def fetch_used_card
    subscription  = UserSubscription.where(id: params[:id]).first
    #we need the payment details for the confirmed order hence passing "confirm" to below function.
    card_id = subscription.get_card("confirm") if subscription.present?
    result = card_id.present? ? { key: "success", card_id: card_id } : { key: 'error', message: "Your are not authorized for this action." }

    render json: result.to_json
  end

  def edit

    if @my_subscription.present?
      #@order = @my_subscription.orders.where(state: :confirm).first
      @order= @my_subscription.orders.where('state = ? and delivery_date > ?',
      'confirm', (ORDER_UPDATE_LIMIT+1).days.from_now.to_date).first


      updated_subscription = Subscription.where(:id => params['updated_subscriber_id']).first
      @cart = Cart.get_cart(current_user.id)
      @cart.prepare_cart(current_user.id, updated_subscription.id, @order.delivery_date)
      @current_cart_items = @cart.get_cart_items
      @total_space = @cart.max_cart_items
      @snacks = Spree::Product.select('id, name')
      @my_subscription_id = updated_subscription.id
      @my_subscription_type = updated_subscription.subscription_type
      @total_space = @cart.max_cart_items
    else
      flash[:error] = "Sorry, You are not authorized for this subscription."
      redirect_to main_app.profile_users_path and return
    end

    render 'show'
  end

  def update
      get_subscription
      @cart = Cart.where('id = ?', params[:cart_id]).first

      @total_space = @cart.max_cart_items
      @current_cart_items = @cart.get_cart_items
      updated_subscription = Subscription.where(:id => params['updated_subscriber_id']).first
      user_subscription_id = params[:id]
      @undelivered_orders= @my_subscription.orders.where('state = ?
        and delivery_date > ?', 'confirm', (ORDER_UPDATE_LIMIT+1).days.from_now.to_date)
      #@order = @my_subscription.orders.where(state: :confirm).first
       @order = @undelivered_orders.first if @undelivered_orders.present?
      if @cart.is_full?
        #@undelivered_orders = @my_subscription.orders.where(state: :confirm)

        #to avoid the back button page crash issue.
        redirect_to main_app.profile_users_path and return if @undelivered_orders.blank?

        @items = @cart.cart_items.select('variant_id')
        @item_array = []

        @items.each do |item|
          @item_array.push({variant_id:  item.variant_id })
        end


        @subscription_offers = Subscription.get_subscription_list

        old_subscription_id = @undelivered_orders.first.subscription_token
        new_subscription_id = Spree::Order.get_unique_subscription_token
        payment_token = @undelivered_orders.first.get_payment_token_for_update
        price = Subscription.subscription_price(@cart.subscription_id)
        plan_id = Subscription.get_current_plan(@cart.subscription_id)


        if @undelivered_orders.first.has_coupon?
          gifted_coupon = @my_subscription.coupon.coupon_code
          coupon = Coupon.get_briantree_discount_id_and_calculate_final_amount(price.to_f, gifted_coupon)
          result = Subscription.update_subscription_with_coupon(old_subscription_id, new_subscription_id, payment_token, price, plan_id, coupon)
        else
          result = Subscription.update_subscription_without_coupon(old_subscription_id, new_subscription_id, payment_token, price, plan_id)
        end

        if result.success?

          @my_subscription.update_attributes(subscription_id: @cart.subscription_id, braintree_token: new_subscription_id)

          @undelivered_orders.each do |undelivered_order|
            undelivered_order.update_attributes(:subscription_token => result.subscription.id, subscription_id: @cart.subscription_id )
            undelivered_order.pack_line_items(@item_array, current_user.id, "USD", request.remote_ip)
            undelivered_order.update_total_and_item_total
          end

          result = subscription_update_mail_params(updated_subscription.subscription_type)
          VeganMailer.update_subscription_email(result).deliver


          @update_success = true
          flash.now[:success] = 'Your Subscription has been updated Successfully !'
          redirect_to spree.snack_queue_orders_path(subscription_id: user_subscription_id) and return

        else
          flash.now[:error] = 'There was some error in updating your subscription, please try again later !'
        end
      else

        flash.now[:error] = 'Please fill all the items and then place the order.'
      end
      @snacks = Spree::Product.select('id, name')
      @my_subscription_id = updated_subscription.id
      @my_subscription_type = updated_subscription.subscription_type

      render 'show'
  end

  def show
    @enable_cancel = true
    @enable_pause = true
    @enable_update = true
    @card = Creditcard.new
  end

  # Description: action will create a new subscription.
  def create_new_subscription
    @subscription_offers = Subscription.get_subscription_list
  end

  protected

  #Description: action will fetch all subscriptions of a user.
  def get_subscription
    @subscriptions = Subscription.all
    @my_subscription = current_user.user_subscriptions.includes(:subscription).where("user_subscriptions.id = ? and user_subscriptions.status = ?", params[:id], "active").first

    if @my_subscription.blank?

      respond_to do |format|
        format.html{ flash[:error] = "Sorry, You are not authorized for this subscription." }
        format.js{ render js: %{location.reload();} }
      end

      redirect_to main_app.profile_users_path and return
    end

  end

=begin
  Description: action will feth the active subscriptions of a User & prepare other parameters like order, card, snacks content
  etc.
=end
  def prepare_subscription
    @subscriptions = Subscription.all
    @my_subscription = current_user.user_subscriptions.includes(:subscription).where("user_subscriptions.id = ? and user_subscriptions.status = ?", params[:id], "active").first

    if @my_subscription.blank?
      flash[:error] = "Sorry, You are not authorized for this subscription."
      redirect_to main_app.profile_users_path and return
    else
      #@order = @my_subscription.orders.where(state: :confirm).first
       @order= @my_subscription.orders.where('state = ? and delivery_date > ?',
        'confirm', (ORDER_UPDATE_LIMIT+1).days.from_now.to_date).first

      @cart = Cart.get_cart(current_user.id)
      @cart.prepare_cart(current_user.id, @order.subscription_id)
      order_subscription_token = @cart.copy_order_to_cart(@order.id)

      @current_cart_items = @cart.get_cart_items
      @subscription_offers = Subscription.get_subscription_list
      @total_space = @cart.max_cart_items
      @snacks = Spree::Product.select('id, name')
      @my_subscription_id = @my_subscription.subscription.id
      @my_subscription_type = @my_subscription.subscription.subscription_type
    end
  end

end