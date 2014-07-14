 class UsersController < ApplicationController

  before_action :authenticate_spree_user!
  before_action :get_user, only: [:pause, :resume]
  respond_to :html, :xml, :js
  include ApplicationHelper
  include MySubscriptionsHelper

#Description: Following action sets the @user & @address_details to be populated in the users#profile Section.
  def profile
    @user = current_user
    redirect_to  '/spree/admin' if  @user.has_spree_role?("admin")

    #if logged in user is fb authenticated user and has selected for new subscription(Of basic/family/double).
    #and during payment it got some error and declined to push any order/subscription then
    # below code will nullify the subscription_id of that user.

    @user.update_attributes(subscription_id: nil) if @user.subscriptions.blank?

    @user.clear_incomplete_addresses
    @addresses = @user.get_addresses
    @subscription_offers = Subscription.get_subscription_list
    @active_subscriptions = @user.fetch_active_subscriptions
    #@active_subscriptions = UserSubscription.fetch_active_subscriptions(@user.id)
    @cards = @user.creditcards.select('id, cc_holder_name as name, cc_part_1, cc_part_2, cc_type')
    @card = Creditcard.new
  end

  # Below action will pause the subscriptions & related orders by calling the method pause_my_subscriptions_and_orders
  def pause
    orders_to_pause = UserSubscription.pause_my_subscriptions_and_orders(@user.id)
    redirect_to main_app.profile_users_path
  end

  # Below action will resume/reset the user subscription again once user goes for resume option.
  def resume
    orders_to_resume = UserSubscription.resume_my_subscriptions_and_orders(@user.id)
    redirect_to main_app.profile_users_path
  end

   def new_acc_address
     @address = Spree::Address.new
   end

   def create_acc_address
     @address = Spree::Address.create(address_params_list)  if params[:address].present?
   end


   def edit_address
        address_id = params[:id]
        @address = Spree::Address.select('id, firstname, lastname, address1,address2, city, zipcode,
                  state_name, address_type').where(id: address_id).first
   end

   #Description: Following action will update logged in users address Related Details.
   def update_address
     @address = Spree::Address.where(id: params[:address][:id]).first
     @address.update_attributes(address_params_list) if @address.present?

   end
  #Description: below action will remove address from my acount section.
  def remove_address
     address_id = params[:id]
     @target_address = Spree::Address.select('id, is_deleted').where(id: address_id).first if address_id

     if @target_address.present?
       @target_address.update_attribute(:is_deleted, true)
       render json: "true".to_json
     else
       render json: "false".to_json
     end

  end

=begin
  Description : Following action will update logged in users personal profile Details.
=end
  def update_account
    @user = current_user
    @user.updating_names = true
    @user.update_attributes(user_params_list)
    @user.remove_errormessages_added_by_spree
  end


=begin
  Description: following action will update logged in users password.

  def update_password
    @user = current_user
    @valid_login = Spree::User.check_valid_user?(@user.email, params[:user][:current_password]) #unless @user.blank?

    if @valid_login
      @user.updating_password = true
      @user.update_attributes(user_params_list)
      sign_in(@user,:bypass => true) if @user.valid?
      mail_params = profile_update_mail_params
      VeganMailer.profile_update_email(mail_params)
    end
  end
=end

   def update_password
     @user = current_user
     @valid_login = Spree::User.check_valid_user?(@user.email, params[:user][:current_password]) #unless @user.blank?
     if @valid_login
       @user.updating_password = true
       @password_updated = @user.update_attributes(user_params_list)
     end

     if @password_updated
       sign_in(@user,:bypass => true) if @user.valid?
       mail_params = profile_update_mail_params
       VeganMailer.profile_update_email(mail_params)
     else
       @user.remove_errormessages_added_by_spree
     end

   end

  def new_address
   @user= current_user
   @address = Spree::Address.new(address_params)
   @address[:address_type] = SHIP
   @address[:user_id] = current_user.id
   @address[:is_complete] = false #this will be marked as complete once after payment only.


   @address.save

    if  @address.errors.blank?
      @hash = {:shipping_address_id => @address.id, :message => 'success'}
      render json: @hash.to_json
    else
      @address.remove_errormessages_added_by_spree
      render json: @address.errors.messages.to_json
    end
  end

  def new_billing_address
    @user = current_user
    render layout: false
  end

  def billing_address
    @user= current_user

    @address = Spree::Address.new(address_params)
    @address[:address_type] = "Billing Address"
    @address[:is_complete] = false
    @address.save

    if  @address.errors.blank?

        hash = {
            :shipping_id => params[:shipping_address_id],
            :billing_address_id => @address.id,
            :message => 'success'
        }
      render json: hash.to_json
    else
      @address.remove_errormessages_added_by_spree
      render json: @address.errors.messages.to_json
    end

  end

  def fetch_address
    @address = Spree::Address.where("id =?", params[:id]).first
    respond_to do |format|
      format.js
    end
  end


  private
  #Description: sets whitelisted user_params_list.
  def user_params_list
    params.require(:user).permit(:id, :email,:first_name, :last_name, :password,
                                 :password_confirmation, :updating_names, :updating_password,
                                 addresses_attributes: [:id, :firstname, :lastname, :phone,:company,
                                                        :address1,:address2, :city,
                                                        :state_name, :zipcode, :country, :is_complete])
  end

  def address_params_list
   params.require(:address).permit(:id, :firstname, :lastname, :phone, :company, :address1, :address2, :city,
                                   :state_name, :zipcode, :country, :user_id, :address_type)
  end

  def address_params
    params.permit(:id, :firstname, :lastname, :phone, :company, :address1, :address2,
                  :city, :state_name, :zipcode, :country, :user_id, :is_complete)
  end

  def get_user
    @user = current_user
  end

end