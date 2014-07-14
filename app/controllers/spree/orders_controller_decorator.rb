module Spree
  class OrdersController < Spree::StoreController
    layout 'application' # Using my applications layout instead of default spree layout.
    ssl_required :show

    before_action :authenticate_spree_user!
    before_action :check_authorization
    #Before executing any action check if user is logged in or not!
    before_action :get_cart_items, only: [:populate]
    include ApplicationHelper

    rescue_from ActiveRecord::RecordNotFound, :with => :render_404

    protect_from_forgery

    respond_to :html, :xml, :js

=begin
 Description: Following action will list out all subscriptions of the User. From this  section
 user can change his snacks directly and can update his subscription as well by using the
 "Update Subscription" option at the top.
=end
    def snack_queue
      #This will fetch the undelivered orders by filtering them through state: :confirm ONLY.
       @sub_items = Spree::Order.get_line_items(current_user.id)
       params_subscription_id  = params[:subscription_id]
       user_id = current_user.id


       @my_subscriptions =current_user.all_subscriptions

       #@my_subscriptions.all

       if @my_subscriptions.present?
        all_subscriptions = Subscription.all

        if params_subscription_id.present?
          @first_subscription = UserSubscription.where(id: params_subscription_id, user_id: user_id).first
          redirect_to spree.snack_queue_orders_path and return if @first_subscription.blank?
        else
        @first_subscription =  @my_subscriptions.first
        end

        @subscription_list = {}

        all_subscriptions.each do |a|
          i = 0
          @my_subscriptions.each do |s|
            if a.id == s.subscription_id
              i = i + 1
              @current_counter  = i if @first_subscription.id == s.id
              sub_row = s.subscription.try(:subscription_type)+ ' ' + i.to_s
              @subscription_list.merge!(sub_row => s.id)
            end
          end
        end

        @first_sub_carts = Cart.create_carts_for_orders(@first_subscription)
        @first_sub_cart_ids = Cart.collect_cart_ids(@first_sub_carts)
        @undelivered_order_ids =  @first_subscription.get_undelivered_order_ids
        @snacks = Spree::Product.select('id, name')
        @subscription_name = Subscription.where(id: @first_subscription.subscription_id).first.subscription_type
      else

      end
    end

=begin
  Description: Below action will allow user to edit his snack queue.
=end
    def edit_snack_queue

      @subscription = UserSubscription.select('id, user_id, subscription_id').where(id: params[:subscription_id]).first
      @snacks = Spree::Product.select('id, name')

      if @subscription.present?
        @carts = Cart.create_carts_for_orders(@subscription)
        @cart_ids = Cart.collect_cart_ids(@carts)
        @undelivered_order_ids = @subscription.get_undelivered_order_ids
      end

      respond_to do |format|
        format.js
      end

    end

 # Description: Below action will update users snacks Queue.

    def update_snack_queue

      order_ids = params[:undelivered_order_ids]
      cart_ids = params[:cart_ids]
      @subscription_id = params[:subscription_id]

      orders = []
      @all_carts_full = Cart.is_carts_full?(cart_ids)

       if @all_carts_full

         order_ids.each do |key, order_id|
           orders.push(order_id)
           order = Spree::Order.where(id: order_id).first
           cart = Cart.where(id: cart_ids[key.to_i]).first
           order_line_items = cart.get_line_items_for_order
           order.pack_line_items(order_line_items, current_user.id, "USD", request.remote_ip)
           order.update_total_and_item_total
           #cart.destroy
         end

         order = Spree::Order.where(id: order_ids["0"]).first
         result = queue_update_mail_params(order)
         VeganMailer.snack_queue_update_mail(result).deliver

       else

       end #end of complete if condition.
    end

=begin
  Description: confirm action will show those orders which was newly created by User. This is a kind of
  Confirmation of order which user has placed recently.
=end
    def confirm
      #@sub_items = Spree::Order.get_receipt_items(current_user.id)
      order_ids = params[:confirmed_order_ids]
      if order_ids.present?
        @sub_items = Spree::Order.get_snack_queue_updated_orders(order_ids)
        @delivery_dates = Spree::Order.get_delivery_dates(order_ids)

      else
        redirect_to main_app.profile_users_path and return if @sub_items.blank?
      end

      #after confirmation if user wishes to reload page then it'll auto redirect user to profile section.
    end

=begin
    Description: Following action will add currently clicked snack to our subscription list.
    Further it will be checking currently added snack count, if it's less than 5/10/20(depending on subscription type)
   then keep adding snacks to subscription else it'll redirect to snacks list page with error message alert.
=end

 #subscription_id, dleivery_date, email, bill_address_id, ship_address_id, bill_address_id,
  #       creditcard_id, last_ip_address, user_id, state, total, item_total, shipment_state, payment_state
    def populate
      if @cart_id.blank? || @card_used.blank?
        #render text: "invalid"
        render json: { result: "failure"}.to_json
      else
        @order = Spree::Order.create(
          subscription_id: @cart.subscription_id,
          email: current_user.email,
          bill_address_id: params[:billing_id],
          ship_address_id: params[:shipping_id],
          creditcard_id: @card_used,
          state: :confirm,
          delivery_date: FIRST_DELIVERY_DAYS.days.from_now,
          shipment_state: "pending",
          payment_state: "pending"
        )

        #subscription_token = @order.get_unique_ID
        subscription_token = Spree::Order.get_unique_subscription_token
        #MyMailer.notify_user_after_cart_creation(current_user, @cart.delivery_date).deliver if @order.present?
        @order.pack_line_items(@item_array, current_user.id, current_currency, request.remote_ip)

        if session[:new_sub].present?

          user_subscription_id = UserSubscription.create_user_subscription(@cart.subscription_id, current_user.id, subscription_token)
          @order.update_attributes(user_subscription_id: user_subscription_id, subscription_token: subscription_token)
          @order.update_total_and_item_total
          #temporarily enabled hub notification for testing ship station delivery functionality.
          #@order.push_notification_to_hub


          Subscription.place_subscription_without_coupon(@order.delivery_date, @order.subscription_id, @card_used, subscription_token)
          @order.subscribe_for_next_two_months
          session[:new_sub] = nil
        end

        @cart.destroy
        @order.update_total_and_item_total
        result = signup_mail_params(@order)  #the params of in signup_mail content is sam
        VeganMailer.new_subscription_mail(result).deliver

        result = vendor_email_params(@order)
        VeganMailer.vendor_email(result).deliver

        #render text: "valid"
        render json: { result: "success", subscription_id: @order.user_subscription_id}.to_json

      end #end of @cart_id.blank? condition

    end #end of populate action.

=begin
managed this controller actions functionality in my_suscriptions Get_payment_info action itself, temporarily marked in commented.
    #Description: Following action will fetch the creditcard used for the order placed & returns the id.
    def get_card
      subscription_id = params[:subscription_id]
      card_id = Spree::Order.extract_card_info(subscription_id) if subscription_id.present?
      result = card_id.present? ? {message: "success", card_id: card_id} : {message: "error"}
      render json: result.to_json
    end
=end

  private
=begin
 Description: Below method will fetch the item lists from the cart, which will be used  while
 creating/placing a new order(using the populate action) .
=end
    def get_cart_items

      @cart_id = params[:cart]
      @card_used = params[:card].present? ? params[:card][:type] : params[:card] #if user has chosen from existing cards.
      @card_used =  params[:card_id] if @card_used.blank?  #if user has chosen from existng cards.

      if @cart_id.present? && @card_used.present?

        @cart = Cart.where(id: @cart_id).first
        @items = @cart.cart_items.select('variant_id')
        @item_array = []

        @items.each do |item|
          @item_array.push({variant_id: item.variant_id })
        end  #end of loop

      end #end of if condition

    end#end of get_cart_items_method

  end #End of orders_controller class

end #end of Spree Module