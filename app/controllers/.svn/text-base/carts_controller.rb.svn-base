class CartsController < ApplicationController

  before_action :authenticate_spree_user!
  respond_to :html, :xml, :js
  include CartsHelper

=begin
Description: following method will add currently clicked snack(from snack list page), to our subscription Cart.
If currently user has a cart (incomplete purchase), then instead of creating a new record in cart, it will
reuse the current_cart and keep on inserting items into it until the cart is full(reaches maximum item input limit)
=end
  def add
   
    @cart = Cart.where(id: params[:cart_id]).first
    @color_box = params[:color_code].to_i
    @updated = false
    @current_line_items_count = @cart.total_items

    unless @cart.is_full?
      @cart_items = @cart.cart_items.build
      @cart_items.prepare_cart_items(params[:variant_id])
      get_updated_cart
      @updated = true
    end
  end
=begin
  Description: Below action is specifically for snack queue pages add snack to Order Section.
=end
  def add_snack_to_queue
    user = current_user
    snack_id = params[:variant_id]

    @cart = Cart.get_my_incomplete_cart(user.id)

    #checking if chosen cart & selected snack ids are coming in params list or not!
    if @cart.present? && snack_id.present? && !@cart.is_full?
      cart_items = @cart.cart_items.build
      cart_items.prepare_cart_items(snack_id)
      @color_box = Cart.get_index(@cart.id, user.id)

      get_updated_cart
      @updated = true
    end

    if @cart.is_full? 
        @next_cart = Cart.get_my_incomplete_cart(user.id)
        
        if @next_cart.present?

          @delivery_date = @next_cart.carts_delivery_date
          @snack_count = @next_cart.get_snack_count
          @cart_index = Cart.get_index(@next_cart.id,user.id)
        end
    end

  end
  #Description: Following action will remove an item from current cart on clicking an item present on it.
  def remove_item
    #@cart = current_cart
    @cart = Cart.where(id: params[:cart_id]).first
    @cart_item_id = params[:cart_item_id]
    @color_box = params[:color_code].to_i
    @deleted = false
    @current_item = @cart.cart_items.where(id: @cart_item_id).first

     if @current_item.present?
       @current_item.destroy
       #@current_item.update_attributes(cart_id: nil) #instead of deleting Here we are just breaking the link.
       @deleted = true
       get_updated_cart
     end

  end

   #Description: Following action will show user the update_subscription page, along with listed snack items. User Can update (add/modfiy/remove)
   # items from the Cart.
  def update_cart
    @subscription_offers = Subscription.get_subscription_list
    @snacks = Spree::Product.select('id, name')
    end


   #Descripition: Following action will Update users current Subscription Type to any other required type of Subscription.
   #Chosing among Small, Medium, large package Systems.
  def change_subscription_type
     
      @cart = current_cart
      @order = Spree::Order.where(id: session[:order_to_modify]).first
      session[:order_to_modify] = nil
      @downgrade_subscription = Subscription.is_downgrade?(@cart.subscription_id, params[:new_sub_id])

       if params[:new_sub_id] != params[:old_sub_id]
         session[:subscription_changed] = true
      end

      if @cart.update_attributes(subscription_id: params[:new_sub_id])
         @changed = true
         @upgrade= true

        if @downgrade_subscription
          drop_count = @cart.max_cart_items - @cart.total_items  #5   10
          CartItem.drop_extra_items(drop_count.abs, @cart.id) if drop_count < 0
          @upgrade = false
        end

      end
      get_updated_cart
  end
   
   #Descriptoin: Folllowing action will Place a subscription into order list(if it's a complete Package) , else it'll notify user
   # that current cart is not complete and user should keep on adding items into it untill it's fully filled out.
  def place_subscription
    
    sub_and_usrsub = session[:sub_and_usrsub]
    redirect_to spree.snack_queue_orders_path  and return if sub_and_usrsub.blank?
    @to_update = Spree::Order.update_order_subscription(current_user.id, sub_and_usrsub[0], sub_and_usrsub[1])

    @cart_update = Cart.where('id = ?', params[:cart_id]).first

    ##### code to copy an carts cartitems to its orders #####
    @items = @cart_update.cart_items.select('variant_id')
    @item_array = []

    @items.each do |item|
      @item_array.push({variant_id:  item.variant_id })
    end

    logger.info @item_array
   ####### got all line items of the cart in @item_array, which will be copied to order using pack_line_item method.

   ######code for rendering
    @snacks = Spree::Product.select('id, name')
    @subscription_offers = Subscription.get_subscription_list
    @order = Spree::Order.update_order_subscription(current_user.id, sub_and_usrsub[0], sub_and_usrsub[1]).first

    #@cart = Cart.new
    # @cart.prepare_cart(current_user.id, @order.subscription_id)
    @cart = Cart.where(id: params[:cart_id]).first
    @current_cart_items = @cart.get_cart_items
    @total_space = @cart.max_cart_items
    @snacks = Spree::Product.select('id, name')
    ### Code for Rendering the same cart in Edit Page ########

    result = Braintree::Subscription.update(
        @to_update.first.subscription_token,
        :id => @to_update.first.get_unique_ID,
        :payment_method_token => @to_update.first.get_payment_token_for_update,
        :price => Subscription.subscription_price(@cart_update.subscription_id),
        :plan_id => Subscription.get_current_plan(@cart_update.subscription_id) #,  #pick up and pass
        #:number_of_billing_cycles => (@to_update.size)
    )

    @new_session = current_user_subscription

    if result.success?

      session.delete(:sub_and_usrsub)
      @new_user_sub = UserSubscription.create_user_subscription(@cart_update.subscription_id, current_user.id, result.subscription.id)
      @old_user_sub = UserSubscription.where('id = ?', sub_and_usrsub[1]).first
      @old_user_sub.update_attributes(:updated_to_id => @new_user_sub)

      @to_update.each do |to_up|
        to_up.update_attributes(:subscription_token => result.subscription.id, user_subscription_id: @new_user_sub, subscription_id: @cart_update.subscription_id )
        to_up.pack_line_items(@item_array, current_user.id, "USD", request.remote_ip)
      end

     flash[:update_sub_notice] = 'Your Subscribtion has been updated Successfully !'
     render '/carts/update_cart'
    else
      flash[:update_sub_notice] = 'There was some error in updating your subscription, please try again later !'
     render '/carts/update_cart'
      current_user_subscription
      #
    end
  end

   #Description: Following action will be called when user hits "Add a new Subscription" from my account / my profile section.
   #On Creating a new subscription app will auto navigate user to update  Subscription page where user can update his current Cart Items.
  def new_subscription
    @sub_id = params[:new_sub_id]
    session[:new_sub] = @sub_id
    current_user.update_attributes(subscription_id: @sub_id)
  end

  def new_cart
    redirect_to main_app.profile_users_path and return if session[:new_sub].blank?
    @user = current_user
    @user.clear_incomplete_addresses
    @active_plan = Subscription.subscription_name(@user.subscription_id)
    @card = Creditcard.new
    @cart = Cart.get_cart(@user.id)
    @cart.prepare_cart(@user.id, @user.subscription_id)
    @cards = @user.creditcards.select('id, cc_holder_name as name, cc_part_1, cc_part_2, cc_type')

    @card_ids = {}
    @cards.each do |card|
      str = card.name + "  " + card.cc_part_1 + "XXXXX" + card.cc_part_2 + "  "+ card.cc_type
      @card_ids.merge!({card.id => str})
    end

    @addresses = @user.addresses.where(address_type: SHIP, is_deleted: false).select('id, firstname AS fname, lastname AS lname,  address1, address2, city, zipcode, state_name, state_id ')

    #unable to access parameters with billing_address parameter.
    @address_ids = {}

    @addresses.each do |address|
       str = address.fname + " " +address.lname + ", "+address.address1+ ", "+ address.address2+ ", "+ address.city + ", "+address.zipcode+", " + ", "+address.state_name
      @address_ids.merge!({address.id => str})
    end

    get_updated_cart
  end

  #Description: Below action will check whether the carts are full or not ( in snack queue page)
  def check_cart_status
    carts = cart_ids = params.to_a[0][0].split(',')
    render text: Cart.is_carts_full?(carts) if carts.present?
  end

=begin
  Description: Below method will find carts status(5/10) how many items present/ total capacity, which will be displayed
  on the snacks list modal window.
=end
  def get_notification
    user_id = current_user.id
    
    if params[:cart_id].present? 
      cart = Cart.where(id: params[:cart_id]).first
      snack_count = cart.present? ? cart.get_snack_count : nil
      render json: {status_count: snack_count}.to_json

    else
      cart = Cart.get_my_incomplete_cart(user_id)
      snack_count = cart.get_snack_count
      cart_index = Cart.get_index(cart.id, user_id)


      render :json => {
        :order_delivery_date => cart.carts_delivery_date,
        :snack_count   => snack_count,
        :color_code => cart_index
    }.to_json

    end
    

=begin
    cart = Cart.where(id: params[:id]).first
    result = cart.present? ? cart.current_size.to_s + " / " + cart.max_size.to_s : nil
    render json: result.to_json
=end
  end

  private
  # Description: Following action will check that users current package/subscription is blank or not. It's redirect user to snacks list
  # Page along with a valid message if current package is Empty.
  def get_updated_cart
    @current_cart_items = @cart.get_cart_items
    @subscription_offers = Subscription.get_subscription_list
    @total_space = @cart.max_cart_items
    @snacks = Spree::Product.select('id, name')
  end


end