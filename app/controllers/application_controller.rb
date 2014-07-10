class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_the_controller
  before_filter :reset_browser_cache
  #before_filter :prompt_offers



  #def prompt_offers
  #  @subscription_offers = Subscription.get_subscription_list
  #end
=begin
Description: Following method will clear browser cache. when user signs out of account and press browser
back button  it prevents displaying user confidential informations.
Argument: NIL
Return: NIL
=end
  def reset_browser_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def get_sub_based_on_type type #change it to confirmed (cart)
    Subscription.find_by_sql(['select s.subscription_type,s.id,date(o.delivery_date) as delivery_date,o.user_subscription_id
                              from subscriptions as s inner join spree_orders as o
                              on o.subscription_id = s.id
                              where  o.user_id = ? and o.state = ? and o.subscription_id = ?', current_user.id, 'cart', type]) if current_user.present?
  end

  def after_resetting_password_path(x)
    '/'
  end

  protected
=begin
Description: following method will redirect user to root after signout is performed by Devise.
Argument List : NIL
Return: NIL
=end

  def after_sign_out_path_for(resource)
    '/'
  end
  #Description: following action will disable js for the admin section to javascript exception.

  def get_the_controller
    logger.info "=================================================\n"
    @spree_admin_js = params['controller'].include?('spree/admin')
  end

=begin
 Description: using current_user method to make use of  currently active user(which is being set by Spree), spree_current_user
Argument List: NIL
Return : NIL
=end
  def current_user
    spree_current_user
  end


  def current_cart
    #session[:cart_id].present? ? Cart.where(id: session[:cart_id]).first : Cart.where(is_current: true, user_id: current_user.id).first
    Cart.where(user_id: current_user.id, is_current: true).last
  end


  #Description: Following method will destory current_order(if exists) just before user logs out of application.
  def check_cart_full?
    current_cart.destroy if current_cart.present? && !current_cart.is_full?
  end

#placing the carts subscribed by the current user in session
#  def current_user_subscription
#
#    sub_type = {}
#    sm = {}
#    med = {}
#    lar = {}
#    sma_cnt,med_cnt,lar_cnt = 0,0,0
#    small =  get_sub_based_on_type 1
#    medium = get_sub_based_on_type 2
#    large = get_sub_based_on_type  3
#
#    # small
#    unless small.blank?
#      small.each do |s|
#        if sma_cnt != s.user_subscription_id
#          sm.merge!({s.id.to_s + '-' +s.user_subscription_id.to_s => {'type' =>s.subscription_type, 'date' => s.delivery_date,'user_sub' => s.user_subscription_id }})
#        end
#        sma_cnt = s.user_subscription_id
#      end
#    else
#      sm = []
#    end
#
#    #medium
#    unless medium.blank?
#      medium.each do |s|
#        if med_cnt != s.user_subscription_id
#          med.merge!({s.id.to_s + '-' +s.user_subscription_id.to_s => {'type' =>s.subscription_type, 'date' => s.delivery_date,'user_sub' => s.user_subscription_id }})
#        end
#        med_cnt = s.user_subscription_id
#      end
#    else
#      med = []
#    end
#
#    #large
#    unless large.blank?
#      large.each do |s|
#        if lar_cnt != s.user_subscription_id
#          lar.merge!({s.id.to_s + '-' +s.user_subscription_id.to_s => {'type' =>s.subscription_type, 'date' => s.delivery_date,'user_sub' => s.user_subscription_id }})
#        end
#        lar_cnt = s.user_subscription_id
#      end
#    else
#      lar = []
#    end
#
#    #merging all three into hash
#    sub_type.merge!({'small' => sm, 'medium' => med, 'large' => lar })
#
#    session[:subscription_current_usr] = sub_type
#
#  end

  #def clear_users_active_subscription
  #  session[:subscription_current_usr] = nil
  #end

end #class end