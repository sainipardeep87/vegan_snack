Spree::Order.class_eval do

  belongs_to :user_subscription
  has_many :order_line_items, :class_name => 'Spree::LineItem', :foreign_key => 'order_id'
  has_one :shipment, :class_name => 'Spree::Shipment', :foreign_key => 'order_id'

  belongs_to :creditcard
  belongs_to :coupon


=begin
  has_many :line_items
  has_many :users, through: :line_items
=end

  def has_coupon?
    self.coupon.present?
  end

=begin
  Description: Below action will Update the line items of an order. once user has updated
  his cart, those line_items will be updated erasing the already associated line items.
 Argument: line_items array, user_id, currency, system_ip
 Return: an object of order.
=end
  def pack_line_items(line_items, user_id, currency, system_ip)

   self.line_items.delete_all  unless self.line_items.blank?

    line_items.each do |item|
      variant = Spree::Variant.where(id: item[:variant_id]).first
      self.contents.add(variant, 1, currency)
    end

   self.update_attributes(user_id: user_id, last_ip_address: system_ip)

  end

=begin
  Description: Following method will calculate currently available items count in Subscription List.
  Argument list: object of Spree::Order Class / current_order
  Return: Fixnum / snack_count
=end

  def total_snacks_count
    snack_count = 0

    self.line_items.each do |line|
      snack_count = snack_count + line.quantity
    end
    snack_count
  end

=begin
  Description: Following method will create the Order Numbers for the newly copied orders when current_order gets full
  Argument List: nil
  Return: Fixnum / random number
=end
  def get_unique_ID
    record = true
    while record
      random = "R#{Array.new(9){rand(9)}.join}"
      record = self.class.where(number: random).first
    end
    random
  end

=begin
  Description: Following method will create the Subscription Number
  Argument List: nil
  Return: Fixnum / random number
=end

  def self.get_unique_subscription_token
    record = true
    while record
      random = "SUB#{Array.new(9){rand(9)}.join}"
      record = Spree::Order.where(subscription_token: random).first
    end
    random
  end

=begin
  Description: Below action will check placed order is users first order or not.
  Argument List: user_id
  Return: boolean
=end

  def is_only_placed_order(user_id)
     Spree::Order.where(user_id: user_id).first.id == self.id
  end

=begin
  Description: Following method will create two copies of my Current Subscription/ current_order
  Argument List : object of Spree::Order class / current_order
  Return : NIL
=end
  def subscribe_for_next_two_months
    create_next_order(SECOND_DELIVERY_DAYS.days.from_now)
    create_next_order(THIRD_DELIVERY_DAYS.days.from_now)
  end

=begin
  Description: following method will create copy of the current subscription/ current_order (with Updated order_id & auto generated id)
  Argument List: object of Spree::Order / self
  Return : NIL
=end
  def create_next_order(delivery_date)
    order = Spree::Order.new(self.attributes.merge!(number: self.get_unique_ID, id: nil, delivery_date: delivery_date, state: :confirm))

    self.line_items.each do |item|
      order.line_items.new(item.attributes.merge!(id: nil, order_id: order.id))
    end
    order.save
    order.update_total_and_item_total
    order
  end

=begin
  Description: Following method will check current_order is the last record in my Order table or not.
  Argument List : Object of Spree::Order Class / current_order
  Return: boolean
=end
  def is_last_order?
    last_order = Spree::Order.last
    self.id == last_order.id && self.user_id == last_order.user_id
  end

=begin
  Description: Following Method will check my Current Subscription/ order is Full or not.
  Our each packet can hold either 5/10/20 snacks only. For each packet size check Subscription Table.
  Argument List : Object of Spree::Order class
  Return: boolean
=end

  def is_full?
    self.total_snacks_count == Subscription.where(id: self.subscription_id).first.quantity
  end

=begin
  Description: Set delivery date of current_order to 35 days from the day when a order is placed
  Argument List : Object of Spree::Order Class
  Return : boolean
=end
  def set_delivery_date(delivery_date)
    self.update_attributes(delivery_date: delivery_date)
  end

=begin
  Description: Following method will fetch the active orders(completed_at:nil)/ state: :confirm  of Current user, further from the
  active order ids, it'll extract the line items against the active order and return it back to controller action.
  Argument List: Current_user.id / FixNum
  Return: line_items/ object of Spree::LineItem
=end
  def self.get_line_items(current_user_id)
    order_ids = Spree::Order.where(user_id: current_user_id, state: :confirm).order(:delivery_date).pluck(:id)

    order_row = {}
    count = 0
    order_ids.each do |order_id|
      order_row[count] = Spree::LineItem.where(order_id: order_id)
      count = count + 1
    end
    order_row
  end

=begin
  Description: Following method will fetch the active orders(completed_at:nil) of Current user, further from the
  active order ids, it'll extract the line items against the active order and return it back to controller action.
  Argument List: Current_user.id / FixNum
  Return: line_items/ object of Spree::LineItem
=end

  def self.get_receipt_items(current_user_id)
    orders = Spree::Order.where(user_id: current_user_id, is_new: true)
    order_ids = Spree::Order.where(user_id: current_user_id, is_new: true).order(:delivery_date).pluck(:id)

    order_row = {}
    count = 0
    order_ids.each do |order_id|
      order_row[count] = Spree::LineItem.where(order_id: order_id)
      count = count + 1
    end

    orders.update_all(is_new: false)
    order_row
  end


=begin
Description: Following Method will fetch the particular Order from our spree_orders Table and return it back to my_subscription controller.
Argument List: Order_id
Return: an object of Spree::Order Class
=end
  def self.get_line_items_associated_with_this_order_id(order_id)
    line_items = Hash.new

    line_items[0] =Spree::LineItem.select('id, variant_id, order_id, quantity').where(order_id: order_id)
    line_items
  end

=begin
Description: Following action will check that Order with this Id exists or not, If exists then return that ID else return current_orders id.
Argument List: order_id received from params and current_order.id
Return: order_id
=end
  def self.get_valid_order_id(order_id, current_order_id)
    Spree::Order.where(id: order_id).first.present? ?  order_id : current_order_id
  end

=begin
  Description: Following method will remove the Orders from table which don't have associated any line Items.
=end
  def self.drop_blank_order(order_id)
    result = Spree::Order.where(id: order_id).first.destroy
  end

=begin
  def self.get_delivery_dates(subscription_items)
    counter = 0
    delivery_dates = {}

    subscription_items.each do |key, value|

      delivery_dates[counter] = Spree::Order.where(id: value.first.order_id).pluck(:delivery_date)
      counter = counter + 1
    end
    delivery_dates
  end
=end

=begin
  Description: Below function will fetch the delivery_dates of requested order ids.
=end
    def self.get_delivery_dates(order_ids)
      Spree::Order.where(id: order_ids).pluck(:delivery_date)
    end

=begin
Description: Following Action will fetch max line item limit of a subscription row.
Argument: an object of Spree::Order
Return : input limit/FixNum
=end
  def get_line_item_limit
    Subscription.where(id: self.subscription_id).first.quantity
  end

  def change_further_subscriptions(user_id)

    @orders = Spree::Order.where("delivery_date > ? AND user_id = ?", self.delivery_date, user_id).order(:delivery_date)
    master_items = self.line_items

     #order.line_items.create(master_items.attributes.merge(id:  nil, order_id: order.id))
      @orders.each do |order|
        order.update_attributes(subscription_id: self.subscription_id)
        order.line_items.delete_all

        master_items.each do |item|
          order.line_items.create(item.attributes.merge(id: nil, order_id: order.id))
        end

      end #end of .each loop
  end # end of method

  #description: below one will check whether a order is pushed to hub or not.
  def pushed?
    self.is_pushed == true
  end

=begin
  Description: Following method will push our Order to Spree Hub using the spree_hub gem provided push call.
  On Successful push flag value true will be returned on failure false will be returned.
  Argument List: order
  Return: true/false(boolean)
=end

  def push_notification_to_hub

    @flag = true

    begin
      item_total = self.item_total.to_f
      sum = {
        "item" => item_total,
        "adjustment"=> self.adjustment_total.to_f,
        "tax" => self.tax_total.to_f,
        "order"=> self.total.to_f,
        "payment" =>  self.total.to_f
      }

      order_params = self.attributes.slice("id", "number", "state", "channel", "email", "currency", "created_at", "delivery_date")

      order_params['status'] = order_params.delete('state')
      order_params['id'] = order_params.delete("number")
      order_params['subscription_type'] = self.user_subscription.subscription.subscription_type
      order_params['placed_on'] = Time.now
      order_params["shipping_method"] =  ORDER_SHIPPING_METHOD
      order_params["shipping_carrier"] = ORDER_SHIPPING_CARRIER

      total_quantity = self.order_line_items.inject(0){|sum,x| sum + x.quantity}

      total = self.order_line_items.map { |x|
        #img_src = REXML::Document.new(view_context.product_image(x.get_related_product)).get_elements("//img")[0].attribute('src').value
        #img_src = IMAGE_URL + x.product.images.first.attachment.url(:small)
        {
          "name" => x.name,
          "quantity" => x.quantity,
         # "image" => img_src,
          "vendor_email" => x.product.vendor.email,
          "vendor_name" => x.product.vendor.name,
          "price" => (item_total / total_quantity) * x.quantity
        }
      }

      bill_hash = self.billing_address.attributes.slice("firstname", "lastname", "address1", "address2", "zipcode", "city", "state_name", "phone")
      ship_hash = self.shipping_address.attributes.slice("firstname", "lastname", "address1", "address2", "zipcode", "city", "state_name", "phone")

      order_params["totals"] = sum
      order_params["line_items"] = total
      order_params["billing_address"] = bill_hash.merge(:country => "US")
      order_params["shipping_address"] = ship_hash.merge(:country => "US")

      #updated the key value "state_name" to "state" for hub push.
      order_params["billing_address"]["state"] = order_params["billing_address"].delete "state_name"
      order_params["shipping_address"]["state"] = order_params["shipping_address"].delete "state_name"


      complete_order = {"order" => [order_params] }

      @res = Spree::Hub::Client.push(complete_order.to_json)

      #self.update_columns(:is_pushed => true) 9861006017
      self.assign_attributes(is_pushed: true)
      self.save(validate: false)

      #hub notification will be only called by the backend process only, as with order if we update any attribute
      #(here wer are updating the is_pushed flag) then we need to update the total and item_total value else
      #they turn 0.00 after each update_attributes hence below method is called after updating the is_pushed flag.
      #self.update_total_and_item_total
    rescue
      @flag = false
    end
    @flag
  end

=begin
 Description: Below method will return Orders of a user ordered by their delivery date.
 Argument List: user_id, subscription_id, user_subscription_id
 Return: Orders.
=end
  def self.update_order_subscription(usr_id, sub_id, usr_sub_id)
    Spree::Order.where(user_id: usr_id, subscription_id: sub_id, user_subscription_id: usr_sub_id, state: 'cart').order(:delivery_date)
  end

=begin
  Description: Below method will return the creditcards token using which Users Subscription is being updated.
  Argument: an object of order class(self)
  Return: token value(string)
=end
  def get_payment_token_for_update
    Creditcard.where(id: self.creditcard_id).first.token
  end

=begin
  Description: Below method call will update an orders total & item_total value as per the associated Subscription plan.
  As we are overriding spree state machine, hence for updating above mentioned parameters had to use update_columns on
 order object.
  Argument: an object of order class(self)
  Return: Updated order.
=end
  def update_total_and_item_total
     price = self.user_subscription.subscription.plan_price
     discount = 0.0

     if self.coupon.present? && Coupon.is_valid?(self.coupon.coupon_code)
      coupon_amount =  self.coupon.discount_rate
      discount  = ((coupon_amount / 100.00) * price).round(2)
     end

    price = price - discount

    #self.update_columns(total: price, item_total: price)
    self.assign_attributes(total: price, item_total: price)
    self.save(validate: false)
  end


=begin
  Description: Below action will prepare the order_row from the supplied order_ids, basically this will get the line items against
  each order and push it into order_row and return it back.
 Argument List: order_ids
 Return: order_row(array)
=end
  def self.get_snack_queue_updated_orders(order_ids)
    order_row = {}

    order_ids.each_with_index do |order_id, count|
      order_row[count] = Spree::LineItem.where(order_id: order_id)
    end
    order_row
  end


  def self.order_placed(order_number, shipstation_order_id)
    begin
      if shipstation_order_id.present?
       order = Spree::Order.select('id, number, state, shipstation_order_id').where(:number => order_number).first
       #order.update_columns(:shipstation_order_id => shipstation_order_id, :state => 'placed', :shipment_state => "ready") if order.present?
       if order.present?
        order.assign_attributes(:shipstation_order_id => shipstation_order_id, :state => 'placed', :shipment_state => "ready")
        order.save(validate: false)
       end
       order.number #returning order number to be visible in spree Hub!
      end

    rescue

    end
  end

  def self.mark_order_paid(token)
    subscription = UserSubscription.select('id').where(braintree_token: token).first

    if subscription.present?
      unpaid_order = subscription.orders.where(payment_state: "pending").first
      #unpaid_order.update_columns(payment_state: 'paid') 9861006017
      unpaid_order.assign_attributes(payment_state: 'paid')
      unpaid_order.save(validate: false)
    else
      logger.info "Sorry, Subscription ID does not match with our Existing records."
    end

  end

  def self.push_paid_order_to_hub
    @orders = Spree::Order.where("is_pushed = ? AND state = ? AND payment_state = ? ", false, 'confirm', 'paid')
    #current_date = (Time.now + HUB_PUSH_LIMIT.days).strftime('%m-%d-%y')
    current_date = (Time.now + 10.days).strftime('%m-%d-%y')

    @orders.each do |order|
      order_delivery_date = order.delivery_date.strftime("%m-%d-%y")

      #if due to some error, previous orders could not be placed then they can be tried later.(so <= condition added)
      if order_delivery_date <= current_date
         order_pushed = order.push_notification_to_hub

         if order_pushed
          order_customer_id = order.user_id
          subscription_id = order.user_subscription_id

          last_order = Spree::Order.where(
            :user_id => order_customer_id,
            :state => 'confirm',
            :user_subscription_id => subscription_id).last

          last_orders_delivery_date = last_order.delivery_date.to_date
          feature_orders_delivery_date = last_orders_delivery_date + FEATURE_DELIVERY_DAYS
          new_one = last_order.create_next_order(feature_orders_delivery_date)

          logger.info 'pushed orders info id = '+ order.id.to_s + ' number = '+ order.number
          logger.info 'newly created orders number is  '+ new_one.number
        else
         logger.info "Sorry, `there is some error in hub push, please wait!"
       end #end of the if else statement

      end #end of order_delivery_date <= current_date condition.

    end #end of the loop
    logger.info "Push order is running " + Time.now.to_s
  end

=begin
  Description: Following method will mark those orders as deleted by updating their
  state attribute to "cancelled"
  Argument List: order_ids (which will be marked as cancelled)
  Return: NIL
=end
  def self.cancel_or_pause_orders_locally(order_ids, new_state)
    orders = Spree::Order.where(id: order_ids) #those orders are supposed to be marked cancelled.

    orders.each do |order|
      order.assign_attributes(state: new_state)
      order.assign_attributes(payment_state: new_state, shipment_state: new_state) if new_state == "canceled"
      order.save(validate: false)
    end

  end
=begin
  Description: Method will mark those orders blocked.
  Argument : order_ids
  Return: NIL
=end
  def self.block_order(order_ids)
    #get orders to be blocked.
    orders = Spree::Order.select('id, is_blocked').where(id: order_ids)

    orders.each do |order|
      order.assign_attributes(is_blocked: true) #blocking those orders.
      order.save(validate: false)
    end
  end

  def self.unblock_order(order_ids)
    orders = Spree::Order.select('id, is_blocked').where(id: order_ids)

    orders.each do |order|
      order.assign_attributes(is_blocked: false) #unblock those orders.
      order.save(validate: false)
    end

  end

=begin
  Description: Method will fetch the creditcard used for the targeted order.
  Argument List: subscription_id
  return: card_id
=end
=begin
  #managed this functionality with user_subscriptions method itself, temporarly marking it commented.
  def self.extract_card_info(subscription_id)
    order = self.select('id, creditcard_id').where(user_subscription_id: subscription_id).first
    order.present? ? order.creditcard_id : nil
  end
=end

=begin
  Description: method will fetch the filetered result of orders on basis of selected delivery date range.
  argument list: start_date, end_date
  return: orders
=end
  def self.filter_on_delivery_date(start_date, end_date)
    self.where('delivery_date >=  ? && delivery_date <= ?', start_date, end_date).order(:delivery_date) if start_date.present? && end_date.present?
  end

=begin
  Description: method will fetch the filetered result of orders on basis of selected order placed on date.
  argument list: start_date, end_date
  return: orders
=end
  def self.filter_on_order_date(start_date, end_date)
    self.where('created_at >=  ? && created_at <= ?', start_date , end_date).order(:created_at) if start_date.present? && end_date.present?
  end

=begin
  Description: method will fetch and return all the orders.
  argument list: nil
  return: orders
=end
  def self.get_all_orders
      self.all.order(:created_at)
  end

=begin
  Description: method will export the filetered result of orders on basis of selected delivery date range.
  argument list: start_date, end_date
  return: orders
=end

  def self.export_on_delivery_date(start_date, end_date)
    self.select('id, number, created_at, delivery_date,state,payment_state,shipment_state, email,
          total, user_subscription_id').where('delivery_date >= ? and delivery_date < ?',start_date, end_date).order(:delivery_date)
  end

=begin
  Description: method will export the filetered result of orders on basis of selected order placed on date.
  argument list: start_date, end_date
  return: orders
=end

  def self.export_on_order_date(start_date, end_date)
    self.select('id, number, created_at, delivery_date,state,payment_state,shipment_state, email,
          total, user_subscription_id').where('created_at >= ? and created_at <= ?',start_date, end_date).order(:delivery_date)
  end

=begin
  Description: method will export all the orders.
  argument list: nil
  return: orders
=end
  def self.export_all_orders
    self.select('id, number, created_at, delivery_date,state,payment_state,shipment_state, email,
          total, user_subscription_id').order(:created_at)
  end

=begin
  Description: method will fetch the discount amount (if coupon present) else the default 0.0 discount amount will be sent.
  argument List: order object
  return: discount_amount.
=end
  def show_discount_amount
     price = self.user_subscription.subscription.plan_price
     discount = 0.00

     #if self.coupon.present? && Coupon.is_valid?(self.coupon.coupon_code)
     if self.coupon.present?
      coupon_amount =  self.coupon.discount_rate
      discount  = ((coupon_amount / 100.00) * price).round(2)
      discount = discount.to_s + " (" + self.coupon.coupon_code + ")"
     end

     discount.to_s
  end

=begin
  Description: Following method will collect customer email IDs and other required parameters in order to Email to customer & Admin.
  Argument List: Card_ids
  Return: nil
=end
  def self.collect_customer_emails_of_expiring_cards(card_ids)
    expiring_orders =  Spree::Order.select('id, user_subscription_id, email, delivery_date, creditcard_id, user_id').where(state: 'confirm',
        payment_state: "pending",shipment_state: "pending", creditcard_id: card_ids).group(:creditcard_id)
    result = []

  #data[:name], data[:email], data[:card_type], data[:card_expiry]
    expiring_orders.each_with_index do |order, index|

      card = order.creditcard

      result[index]= {
        name: order.user.first_name,
        email: order.email,
        card_type:  card.cc_type,
        card_expiry: card.expiration_month + "/" + card.expiration_year,
        subscription_id: order.user_subscription_id,
        subscription_type: order.user_subscription.subscription.subscription_type,
        delivery_date: order.delivery_date.strftime("%B %d, %Y")
      }

    end
    #[{:email=>"a@a.com", :subscription_type=>"Basic Snack Pack", :delivery_date=>"July 24, 2014"}]
    result
  end
=begin
  Description: Following action will collect the user_subscription ids for the creditcards which are expiring in Current Month.
  Argument List: card_ids
  return: user_subscription_ids
=end
  def self.collect_user_subscription_ids_for_expired_cards(card_ids)
    allowed_states = ["confirm", "paused"]
    Spree::Order.where(state: allowed_states, payment_state: "pending",
      shipment_state: "pending", creditcard_id: card_ids).pluck(:user_subscription_id).uniq
  end

end