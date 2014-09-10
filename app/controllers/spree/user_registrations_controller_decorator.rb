# Description: Overriding spree provided UserRegistrationController to customize as per my requirement
Spree::UserRegistrationsController.class_eval do
  layout 'application',skip: [:wizard_new]
  layout 'wizard_layout',only: [:wizard_new]

	#skip_before_action :current_user, only:  [:new, :create]
  skip_filter(*_process_action_callbacks.map(&:filter), only:[:create, :new, :show_address_form, :check_phone_no_format, :get_phone_no])
  before_action :check_current_user_1, :get_subscription_offers, except:[:check_phone_no_format, :get_phone_no]
  include Spree::OrdersHelper
  include ApplicationHelper
  include UserRegistrationsHelper
  respond_to :html, :xml, :js
  #before_action :get_credit_card, only: [:create]
  before_action :get_phone_no, only: :check_phone_no_format

# Description: new action has been overridden over spree provided new action; mainly initialization of users address has been done in this Section.
  #trigma wizard code
 def wizard_new
 
  @subtype=params[:sub_type]
  @package = ""
  @image = ""
  if @subtype == "1"
    @package = "Basic Snack Pack"
    @image = "/../assets/new-design/img1-mem.jpg"
  elsif @subtype == "2"
    @package = "Double Snack Pack"
    @image = "/../assets/new-design/img2-mem.jpg"
  else
    @package = "Family Snack Pack"
    @image = "/../assets/new-design/img3-mem.jpg"
  end
  @subscription = Subscription.find_by_id @subtype
  unless @subscription.blank?
    if request.env['omniauth.auth'].present?
      params = request.env["omniauth.params"]

      @fb_data = fetch_facebook_params
      @user = Spree::User.where(email: @fb_data[:email]).first


      if (@user.blank? && params["login"].present?) || (@user.present? && is_ordinary_user?(@user.facebook_token) && params["login"].present?)

      #here need to check if it's a fb registered user + in params we must receive login
      #if !is_ordinary_user?(@user.facebook_token) && params["login"].present?
       #use the @not_yet_fb_signed_up to notify the message at the top.

        @not_yet_fb_signed_up = true
        @user = Spree::User.new
        @user.addresses.build
        @user.creditcards.build

     #user does not registered yet & coming for signup(or login params is blank.)
      elsif @user.blank? && params["login"].blank?
        @user = Spree::User.new(email: @fb_data[:email], facebook_token: @fb_data[:fb_token], image: @fb_data[:image])
        @user.addresses.build
        @user.creditcards.build
        @user.addresses.first.firstname = @fb_data[:firstname]
        @user.addresses.first.lastname = @fb_data[:lastname]

      #user is registered & still trying for signup via facebook
      elsif @user.present? && params["login"].blank?
        @registered_email = @user.email
        @user = Spree::User.new
        @user.addresses.build
        @user.creditcards.build
      else
        #update the token if @user_founds token is not same as the @fb_token
        @user.update_attributes(facebook_token: @fb_data[:fb_token], image: @fb_data[:image]) if @user.facebook_token != @fb_data[:fb_token]
        sign_in(:spree_user, @user)
        redirect_to spree.snack_queue_orders_path
      end

    else
      @user = Spree::User.new
      @user.addresses.build
      @user.creditcards.build

    end
    
else
  redirect_to root_path
end
       
  end
  #trigma wizard code end

 def new
     if request.env['omniauth.auth'].present?
      params = request.env["omniauth.params"]

      @fb_data = fetch_facebook_params
      @user = Spree::User.where(email: @fb_data[:email]).first


      if (@user.blank? && params["login"].present?) || (@user.present? && is_ordinary_user?(@user.facebook_token) && params["login"].present?)

      #here need to check if it's a fb registered user + in params we must receive login
      #if !is_ordinary_user?(@user.facebook_token) && params["login"].present?
       #use the @not_yet_fb_signed_up to notify the message at the top.

        @not_yet_fb_signed_up = true
        @user = Spree::User.new
        @user.addresses.build
        @user.creditcards.build

     #user does not registered yet & coming for signup(or login params is blank.)
      elsif @user.blank? && params["login"].blank?
        @user = Spree::User.new(email: @fb_data[:email], facebook_token: @fb_data[:fb_token], image: @fb_data[:image])
        @user.addresses.build
        @user.creditcards.build
        @user.addresses.first.firstname = @fb_data[:firstname]
        @user.addresses.first.lastname = @fb_data[:lastname]

      #user is registered & still trying for signup via facebook
      elsif @user.present? && params["login"].blank?
        @registered_email = @user.email
        @user = Spree::User.new
        @user.addresses.build
        @user.creditcards.build
      else
        #update the token if @user_founds token is not same as the @fb_token
        @user.update_attributes(facebook_token: @fb_data[:fb_token], image: @fb_data[:image]) if @user.facebook_token != @fb_data[:fb_token]
        sign_in(:spree_user, @user)
        redirect_to spree.snack_queue_orders_path
      end

    else
      @user = Spree::User.new
      @user.addresses.build
      @user.creditcards.build

    end
    @subscriptions = Subscription.select('id, subscription_type', 'plan_price')
    @snacks = Spree::Product.limit(6)
    @snacks.sort_by! { |x| x[:name].downcase }

  end

# Description: create action of Spree has been overridden here and address attributes are being saved #in respective Model
  def create
    sub_id = params[:spree_user][:sub_type].blank? ? "1" : params[:spree_user][:sub_type]
    coupon_code = params[:spree_user][:coupon_code]
    @cart = Cart.new
    @user = build_resource(user_params_list)

    credit_card_params = params[:spree_user][:creditcards_attributes]["0"]
    respond_to do |format|
      format.js do
    if @user.valid?
      billing_address = @user.addresses.last
      result = Creditcard.create_customer_and_creditcard_over_braintree(billing_address, @user.email,credit_card_params)
      @success = result.success? ? true : false
      puts "i am in user success with params#{@success} and #{billing_address}"


      if @success && @user.save
        customer =result.customer
        @credit_card_details = Creditcard.update_creditcard(customer.credit_cards.first, @user.id)
        @user.push_subscription_and_customer_id(sub_id, customer.id)
        @cart.prepare_cart(@user.id, sub_id)
        @user.update_bill_and_ship_address_details
        @user.update_address_type_and_name_fields

        #####code for creating new orders#####
        # first order
        plan_price = Subscription.where(id: sub_id).first.plan_price.to_f
        @order_1 = place_order_registration(sub_id, FIRST_DELIVERY_DAYS.days.from_now, @user, @credit_card_details.id, request.remote_ip, plan_price)
        new_token_1 = @order_1.get_unique_ID
        new_token_subscr = Spree::Order.get_unique_subscription_token
        #entry in user subscription

        coupon = Coupon.get_briantree_discount_id_and_calculate_final_amount(plan_price, coupon_code)

        if coupon.present?
          user_subscription_id = UserSubscription.create_user_subscription(sub_id, @user.id, new_token_subscr, coupon["id"])
          sub_result = Subscription.place_subscription_with_coupon(@order_1.delivery_date, @order_1.subscription_id, @credit_card_details.id, new_token_subscr, coupon)
          @order_1.update_attributes(coupon_id: coupon["id"])
          Coupon.raise_counter(coupon["id"])
        else
          user_subscription_id = UserSubscription.create_user_subscription(sub_id, @user.id, new_token_subscr)
          sub_result = Subscription.place_subscription_without_coupon(@order_1.delivery_date, @order_1.subscription_id, @credit_card_details.id, new_token_subscr)
        end

        @order_1.update_attributes(number: new_token_1, user_subscription_id: user_subscription_id, subscription_token: new_token_subscr)

        # second order
        @order_2 = place_order_registration(sub_id, SECOND_DELIVERY_DAYS.days.from_now, @user, @credit_card_details.id, plan_price)
        new_token_2 = @order_2.get_unique_ID
        @order_2.update_attributes(number: new_token_2, subscription_token: new_token_subscr, user_subscription_id: user_subscription_id)

        # third order
        @order_3 = place_order_registration(sub_id, THIRD_DELIVERY_DAYS.days.from_now, @user, @credit_card_details.id, plan_price)
        new_token_3 = @order_3.get_unique_ID
        @order_3.update_attributes(number: new_token_3, subscription_token: new_token_subscr, user_subscription_id: user_subscription_id)

        #creating new line-items-default

        create_new_line_items(sub_id,@order_1)
        create_new_line_items(sub_id,@order_2)
        create_new_line_items(sub_id,@order_3)

       @order_1.update_total_and_item_total #reupdated total & item_total as its changed by is_pushed = 1 , in push notification method.
       @order_2.update_total_and_item_total
       @order_3.update_total_and_item_total
       ######################################

       sign_in(:spree_user, @user)
       session[:spree_user_signup] = true
       #MyMailer.notify_user_after_registration(current_user).deliver
       result = signup_mail_params(@order_1)
       VeganMailer.signup_email(result).deliver

       result = vendor_email_params(@order_1)
       VeganMailer.vendor_email(result).deliver

       render js: %(window.location.href='/spree/orders/snack_queue') and return

     else
       @user.destroy
       @user.remove_errormessages_added_by_spree
       @user.errors.add(:creditcards,"invalid credit card details")
     end
     else
       
     end
     end
  end

  end


=begin
  #Description: following action will render Signup Form for fcebook authenticated User.
  #Arument :NIL
 #REturn :NIL
=end
=begin
  def new_facebook_signup
    @fb_data = fetch_facebook_params

    @user = Spree::User.where(email: @fb_data[:email]).first

    if @user.blank?
      @user = Spree::User.new(email: @fb_data[:email], facebook_token: @fb_data[:fb_token])
      @user.addresses.build
      @user.addresses.first.firstname = @fb_data[:firstname]
      @user.addresses.first.lastname = @fb_data[:lastname]


    else
      @user.update_attributes(facebook_token: @fb_data[:fb_token]) if @user.facebook_token != @fb_data[:fb_token] #update the token if @user_founds token is not same as the @fb_token
      sign_in(:spree_user, @user)
      redirect_to main_app.profile_users_path
    end

  end
=end
=begin
  def create_facebook_auth_user

    @user = Spree::User.new(user_params_list)
    fb_pass  = @user.facebook_token.last(8)
    @user.password =  @user.password_confirmation = fb_pass #as we are not asking fb authenticated user his password hence assigning the last 8 characters of his fb token as his password.

    if @user.save
      sign_in(:spree_user, @user)
      redirect_to main_app.profile_users_path
    else
      @user.remove_errormessages_added_by_spree
      render 'new_facebook_signup'
    end

  end
=end
=begin
    Description: following action will extract required parameters from long facebook params list and will be used in signup form
    Argument LIST: NIL
    Return: filtered params list(email, firstname, lastname)
=end
  def fetch_facebook_params

    @fb_details = request.env['omniauth.auth']
    redirect_to main_app.root_path if @fb_details.nil?

    @fb_data = Hash.new
    @fb_data[:email] = @fb_details[:info][:email]
    @fb_data[:firstname] =  @fb_details[:info][:first_name]
    @fb_data[:lastname] = @fb_details[:info][:last_name]
    @fb_data[:fb_token] =  @fb_details[:credentials][:token]
    @fb_data[:image] = @fb_details[:info][:image].concat("?type=#{SIZE}")

    return @fb_data
  end

#Description: Following action will check added email is already registered with Application or not
  def check_email
    email =  params[:spree_user][:email]
    user =  Spree::User.new(email: email)
    return_message = user.is_valid_email?

    if return_message.nil?
      render :json =>  {:success => "true"} and return
    else
      render :json => {:error => return_message} and return if return_message.present?
    end

  end

#Descripton: Following action will check entered phone number is in proper format or not(XXX-XXX-XXXX)
   def check_phone_no_format
    is_valid = Spree::Address.is_phone_valid?(@phone)
    render text: is_valid
   end

# Description: Adding parameters to permission list; so those will be allowed for create/update action
  private
    def user_params_list
      params.require(:spree_user).permit(
          :id, :email, :password, :password_confirmation, :updating_password, :facebook_token, :image, :coupon_code, :sub_type,
          :addresses_attributes => [:id,:phone, :firstname, :lastname, :company, :address1, :address2, :city, :state_name, :zipcode, :country],
          :creditcards_attributes => [:id, :cardholder_name, :card_no, :cvv, :month, :year,:first_name,:last_name]
      )
    end


    def check_current_user_1
      if current_user.present?
        respond_to do |format|
          format.html {redirect_to main_app.profile_users_path}
        end
      end
    end

    def get_subscription_offers
      @subscription_offers = Subscription.get_subscription_list
    end

    def place_order_registration(sub_id, date, user, card, ip = nil, plan_price)
         Spree::Order.create(
             :subscription_id => sub_id,
             :delivery_date => date,
             :email => user.email,
             :bill_address_id => user.bill_address_id,
             :ship_address_id => user.ship_address_id,
             :creditcard_id => card,
             :last_ip_address => ip,
             :user_id => user.id,
             :state => :confirm,
             :total =>  plan_price,
             :item_total => plan_price,
             :shipment_state => "pending",
             :payment_state => "pending"
        )


    end

    def create_new_line_items(sub_id, order)
      @item_array = []
      @products = Spree::Product.all
      sub_id = sub_id.to_s
      cnt_chk = 0

      case sub_id
        when "1"
          @items = @products.take(5)
        when "2"
          @items = (@products * 2).take(10)
        when "3"
          @items = (@products * 5).take(20)
      end

      @items = @items.sort{|a,b| a <=> b}
        #actually need to send item.spree_variant.id,
        # since not using variants and 1-to-1 association is there passing product id
        #if variants are created issue will come please note.
      @items.each do |item|
        if cnt_chk != item.id
          Spree::LineItem.create(variant_id: item.id, order_id: order.id, quantity: @items.map(&:id).select{|e| e == item.id}.size )
          end
        cnt_chk = item.id
      end

    end

    # action will validate the phone number field and strip input if it's coming with any kind of spaces then assign it to
    # a @phone variable.
    def get_phone_no
      phone_no = params[:phone_no] if params[:phone_no].present?
      @phone = phone_no.respond_to?("strip") ? phone_no.strip : nil
    end


end