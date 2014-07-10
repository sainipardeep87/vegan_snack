class Subscription < ActiveRecord::Base

  has_many :user_subscriptions
  has_many :orders, :through => :user_subscriptions, :source => :orders
  has_many :users, :through => :user_subscriptions, source: :user
  scope :get_subscription_list, lambda { pluck(:subscription_type, :id, :plan_price) }

  validates_presence_of :subscription_type, :plan_id, :quantity, :plan_price, message: "Mandatory Field"

  validates_numericality_of :quantity, only_integer: true, greater_than: 0
  validates_numericality_of :plan_price, greater_than: 0

  validates_length_of :subscription_type, :plan_id, :quantity, :plan_price, maximum: 50,
      message: "Maximum 50 Characters Allowed"

=begin
  Description: Below function will return the maximum limit of snacks in a subscription packet.
  argument list: subscription_id
  return: max quantity.
=end
  def self.get_max_quantity(subscription_id)
    Subscription.where(id: subscription_id).first.quantity
  end
=begin
  Description:function will check whether the subscription has opted for downgrade/upgrade.
  Argument List: old_subscription_id, new_subscription_id
  return: true/false.
=end
  def self.is_downgrade?(old_subscription_id, new_subscription_id)
    self.get_max_quantity(new_subscription_id) < self.get_max_quantity(old_subscription_id) #case of Downgrade
  end

=begin
  Description: Below function will fetch the subscription type value and return it.
  Argument List : Subscription_id
  return: subscription_type.
=end
  def self.subscription_name(subscription_id)
    Subscription.where(id: subscription_id).first.subscription_type
  end

=begin
  Description: function will fetch the subscription plan price.
  Argument List: subscription_id
  Return: plan price.
=end
  def self.subscription_price(subscription_id)
    Subscription.where(id: subscription_id).first.plan_price
  end

=begin
  Description: Function will return the plan_id of the selected subscription type.
  Argument List: Subscription_id
  Return: plan_id.
=end
  def self.get_current_plan(subscription_id)
    Subscription.where(id: subscription_id).first.plan_id
  end

=begin
  Description: Function will place the subscription (without any coupon associated with it).
  Argument List: delivery_date, subscription_id, card_id, token
  Return: if placed the object will be returned else error will be logged in console.
=end
  def self.place_subscription_without_coupon(delivery_date, subscription_id, card_id, token)

    plan_id = Subscription.get_current_plan(subscription_id)
    payment_token = Creditcard.get_token(card_id)

    begin
      result = Braintree::Subscription.create(
        :id => token,
        :payment_method_token => payment_token,
        :plan_id => plan_id,
        #(placed on 1st june, delivery on 11th june, then bill on 11-7 = 4th june)
        #:first_billing_date => 1.day.from_now
         :first_billing_date => delivery_date - ORDER_UPDATE_LIMIT.days
      )
    rescue Exception => error
      logger.info "Error while creating subscription" + error.to_s
      OpenStruct.new(:success? => false, :message => error)
    end

  end

=begin
  Description: Function will place the subscription (having coupon associated with it).
  Argument List: delivery_date, subscription_id, card_id, token
  Return: if placed the object will be returned else error will be logged in console.
=end
  def self.place_subscription_with_coupon(delivery_date, subscription_id, card_id, token, coupon)

    plan_id = Subscription.get_current_plan(subscription_id)
    payment_token = Creditcard.get_token(card_id)

    begin

    result = Braintree::Subscription.create(
      :id => token,
      :payment_method_token => payment_token,
      :plan_id => plan_id,
      :first_billing_date => delivery_date - ORDER_UPDATE_LIMIT.days,
      :discounts => {
        :add => [
          {
            :inherited_from_id => coupon["braintree_discount_id"],
            :amount => BigDecimal.new(coupon["amount"].to_s)
          }
        ]
      }
    )
    rescue Exception => error
      logger.info "Error while creating subscription" + error.to_s
      OpenStruct.new(:success? => false, :message => error)
    end

  end

=begin
  Description: Below method will update the subscription over braintree.
  argument list: old_subscription_otken, new_subscription_id, payment_token, price, plan_id
  Return: if placed the object will be returned else error will be logged in console.
=end
  def self.update_subscription_without_coupon(old_id, new_id, payment_token, price, plan_id)

    begin
      Braintree::Subscription.update(
        old_id,
        :id => new_id,
        :payment_method_token => payment_token,
        :price => price,
        :plan_id => plan_id
      )
    rescue  Exception => error
      logger.error "Error in updating Users subscription " + error.to_s
      OpenStruct.new(:success? => false, :message => error)
    end #end of begin_rescue block

  end #end of the method.

=begin
  Description: Below method will update the subscription over braintree when the subscription is associated
  with coupon.
  argument list: old_subscription_otken, new_subscription_id, payment_token, price, plan_id
  Return: if placed the object will be returned else error will be logged in console.
=end
  def self.update_subscription_with_coupon(old_id, new_id, payment_token, price, plan_id, coupon)

    begin
      result= Braintree::Subscription.update(
        old_id,
        :id => new_id,
        :payment_method_token => payment_token,
        :price => price,
        :plan_id => plan_id,
        :discounts => {
        :update => [
          {
            :existing_id => coupon["braintree_discount_id"],
            :amount => BigDecimal.new(coupon["amount"].to_s)
          }
        ]
        }
      )
    rescue  Exception => error
      logger.error "Error in updating Users subscription " + error.to_s
      OpenStruct.new(:success? => false, :message => error)
    end #end of begin_rescue block

  end

end