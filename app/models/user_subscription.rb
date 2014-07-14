class UserSubscription < ActiveRecord::Base

  belongs_to :user, class_name: 'Spree::User', foreign_key: 'user_id'
  belongs_to :subscription
  belongs_to :coupon

  has_many :orders, class_name: 'Spree::Order', foreign_key: 'user_subscription_id'
  has_many :order_line_items, :through => :orders, :source => :order_line_items

=begin
  Description: below method will return the user_subscrition id.
  Argument list:subscription_id, user_id, braintree token value.
  Return: user_subscription id.
=end
  def self.create_user_subscription(sub_id, user_id, braintree_token, coupon_id = nil)
    @user_subscription = UserSubscription.create(
      subscription_id: sub_id,
      user_id: user_id,
      braintree_token: braintree_token,
      coupon_id: coupon_id
      )
    @user_subscription.id
  end

=begin
  Description: below method will fetch values from the last modified usersubscription record.
  Argument: current_user.id
  Return: user_subscription object.
=end
  def self.get_values_from_last_modified_record(current_user_id)
    user_subscription = UserSubscription.includes(:subscription).where(user_id: current_user_id).order("updated_at desc").first
    "#{user_subscription.subscription.id}-#{user_subscription.id}"
  end

=begin
  Description: below function will return all the undelivered orders ids.
  argument: user_subscription object.
  return: order_ids
=end
  def get_undelivered_order_ids

    #enable this one for previous restricted conditioned(pause/resume)
    #orders =self.orders.select('id, delivery_date').where('spree_orders.delivery_date > ?', Time.now).limit(3)
    orders = self.orders.select('id, delivery_date').where('spree_orders.state in (?) ', ['confirm', 'placed']).limit(3)

    order_ids = {}

    orders.each_with_index do |order, index|
      order_ids.merge!(index => order.id)
    end

    order_ids
  end

=begin
  Description: Function will check whether subscriptions any of the order is in locking period or not.
  argument list: user_subscription object.
  return: boolean
=end
  def is_under_process?
    #if true then this sub has got orders which are under process(by payment / shipment)
    self.orders.where('(delivery_date <= ? and delivery_date > ?) or (state = ? and payment_state = ?)',  ORDER_UPDATE_LIMIT.days.from_now.to_date, Time.now, 'placed', 'paid').present?
  end

=begin
  Description:
=end
  def get_under_process_orders_number
  order = self.orders.where('(delivery_date <= ? and delivery_date > ?) or (state = ? and payment_state = ?)',  ORDER_UPDATE_LIMIT.days.from_now.to_date, Time.now, 'placed', 'paid').first
  order.present?  ? order.number : nil
  end

=begin
  Description: Following method will mark the subscription canceled over braintree, further on getting proper
  response from braintree(result.id) we are marking the same subscription as deleted in application db further
  the same action is taken for the associated orders as well.
  Arugment List: an object(of user_subscription class)
  Return: NIL
=end
  def cancel_or_pause_subscription(new_status)

    subscription_token = self.braintree_token
    subscription_id = self.id

    if subscription_token.present?
      begin
        result = Braintree::Subscription.cancel(subscription_token)

        if result.subscription.id == subscription_token
          cancel_or_pause_subscription_locally(new_status)
          order_ids = get_order_ids_for_cancel_or_pause
          result = Spree::Order.cancel_or_pause_orders_locally(order_ids, new_status)
          return result.present ? true : false
        end
      rescue Exception => error
        logger.info "Some error in subscription Cancelation" + error.to_s
      end

    end #end of the if block.

  end

=begin
  Description: Folowing method will mark the subscriptions  as deleted in local/application DB.
  argument List: new status(paused / canceled)
  return: retuns the orders associated with the subscription(which will be marked as canceled as well)
=end

  def cancel_or_pause_subscription_locally(new_status)
    self.update_attributes(status: new_status, canceled_at: Time.now) if new_status == "canceled"
    self.update_attributes(status: new_status, paused_at: Time.now) if new_status == "paused"
  end

  #this will return the orders which can be cancelled(having state: confirm, payment: pending, shipment: pending)
  def get_order_ids_for_cancel_or_pause
    #here sending back the order ids which are supposed to be marked canceled.
    self.orders.where("state = ? and payment_state = ? and shipment_state = ? ", 'confirm', 'pending', 'pending').pluck(:id)
  end

=begin
  Description: Function will pause users subscription and related orders by altering their state/status to "paused"
  Argument List: user id( current users ID)
  return: nil
=end
  def self.pause_my_subscriptions_and_orders(user_id)
    requester_subscriptions = UserSubscription.where(user_id: user_id, status: 'active')

    requester_subscriptions.each do |sub|
      sub.cancel_or_pause_subscription("paused")
    end

  end

=begin
  Description: Function will resume users subscription and related orders by altering their state/status to "active"
  Argument List: User_id
  return type: nil
=end
  def self.resume_my_subscriptions_and_orders(user_id)
    requester_subscriptions = UserSubscription.where(user_id: user_id, status: 'paused')

    requester_subscriptions.each do |sub|
      sub.resume_subscription
    end

  end

=begin
  Description: Function will perform resume on the paused subscriptions, but the functionality has varierty depending
  on subscription is associated with any coupon code or not.
  Argument list: nil
  Return : nil
=end
  def resume_subscription(card_id)
    delivery_date = FIRST_DELIVERY_DAYS.days.from_now
    subscription_id = self.subscription_id
    token = Spree::Order.get_unique_subscription_token
    coupon_code = self.check_for_coupon

    if coupon_code.blank?
      result = Subscription.place_subscription_without_coupon(delivery_date, subscription_id, card_id, token)
    else
       plan_price = self.subscription.plan_price.to_f
       coupon = Coupon.get_briantree_discount_id_and_calculate_final_amount(plan_price, coupon_code)
       result = Subscription.place_subscription_with_coupon(delivery_date, subscription_id, card_id, token, coupon)
    end

    if result.success?
      token = result.subscription.id
      order_with_coupon = self.orders.where("state = ? and coupon_id is not ?", "paused", nil).first

      self.update_attributes(coupon_id: coupon["id"]) if coupon.present?

      if coupon.present? && order_with_coupon.present?
        order_with_coupon.assign_attributes(coupon_id: coupon["id"])
        order_with_coupon.save(validate: false)
      end

      order_with_coupon.update_total_and_item_total if order_with_coupon.present?

      self.update_attributes(braintree_token: token, status: "active", resumed_at: Time.now)
      paused_orders = self.orders.where(state: 'paused')

      paused_orders.each_with_index do |order, index|
        order.assign_attributes(state: "confirm",
          delivery_date: FIRST_DELIVERY_DAYS.days.from_now, subscription_token: token) if index == 0
        order.assign_attributes(state: "confirm",
          delivery_date: SECOND_DELIVERY_DAYS.days.from_now, subscription_token: token) if index == 1
        order.assign_attributes(state: "confirm",
          delivery_date: THIRD_DELIVERY_DAYS.days.from_now, subscription_token: token) if index == 2
        order.assign_attributes(creditcard_id: card_id)

        #disabling the validation as this might effect total/item total value
        #(those are calculated as spree provided state machine rule)
        order.save(validate: false)
      end

    end #end of the result.success?

    type = self.subscription.subscription_type.to_s
    date = self.orders.where(state: 'confirm').first.delivery_date.strftime("%B %d, %Y").to_s
    type + " " + date  #"BasicPack  20thjuly"

  end #end of the function.

=begin
  Description: Following function will check whether the order is associated with any coupon code or not.
  if it's associated then it will return the coupon code else nil will be returned.
  Argument List: nil
  Return: boolean
=end
  def check_for_coupon
    coupon = self.orders.where(state: "paused").first.coupon
    valid_coupon = Coupon.is_valid?(coupon.coupon_code) if coupon.present?
    valid_coupon.present? ? valid_coupon.coupon_code : nil
  end

=begin
  Description: Following action will fetch the first undelivered order of each active subscription.
  Argument List: user_id.
  Return: Array of hash (containging subscription id, type, delivery_date, status attributes)
=end
=begin
  def self.fetch_active_subscriptions(user_id)

    permited_status = ['confirm','placed', 'paused']
    active_subscriptions= UserSubscription.includes(:orders).where('spree_orders.state in (?) and user_subscriptions.user_id = ? ',permited_status , user_id)
    result = []

    active_subscriptions.each do |sub|

      first_order =  sub.orders.where('state != ?', "canceled").first

      result.push({
          id: sub.id,
          type: sub.subscription.subscription_type,
          delivery_date: first_order.delivery_date.strftime("%B %d, %Y"),
          status: first_order.state
        })
    end
    result #return the final active subscription_orders result.
  end
=end
  def self.get_my_paused_subscription(user, subscription_id)
    #current_user.user_subscriptions.where('user_subscriptions.id = ? and user_subscriptions.status = ? ', params[:id], "paused").first
    user.user_subscriptions.where('user_subscriptions.id = ? and user_subscriptions.status = ? ', subscription_id, "paused").first
  end

=begin
  Description: Below method will fetch the payment prompt message regarding how much amount will be deducted from customers
  account(with/without coupon code, check on expired coupon code).
  Argument List: nil
  return: payment_message(string)
=end

  def get_payment_message
    final_price =self.subscription.plan_price.to_f
    coupon_found = self.orders.where(state: 'paused').first.coupon.present?
    payment_message = "You will be charged $#{final_price}/month for this subscription."
    payment_message = self.coupon.price_with_coupon(final_price) if coupon_found
    payment_message
  end

  def get_card(desired_status)
    order = self.orders.where(state: desired_status).first
    order.present? ? order.creditcard_id : nil
  end


=begin
  Description: Function will mark the user_subscription as blocked and further initiate call to mark related orders blocked.
  Argument List: NIL
  Return: NIL
=end
  def block_subscription
    self.update_attributes(is_blocked: true)
    order_ids = self.orders.where("state = ? and payment_state = ? and shipment_state = ? ", 'paused', 'pending', 'pending').pluck(:id)
    Spree::Order.block_order(order_ids)
  end

  def unblock_subscription
    self.update_attributes(is_blocked: false)
    order_ids = self.orders.where(is_blocked: true).pluck(:id)
    Spree::Order.unblock_order(order_ids)
  end

end
