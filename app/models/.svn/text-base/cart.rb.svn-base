class Cart < ActiveRecord::Base

  has_many :cart_items, dependent: :destroy
  belongs_to :user

=begin
  Description: Following method will prepare the cart when a new subscription is being created.
  argument list: user_id, subscription_id, delivery_date(default 14days)
  Return: cart object.
=end
  def prepare_cart(user_id, subscription_id, delivery_date =FIRST_DELIVERY_DAYS.days.from_now)
    self.update_attributes(user_id: user_id, subscription_id: subscription_id,  delivery_date: delivery_date)
  end

=begin
  Description: Below method will find the maximum capacity of a cart.
  Argument List: an object of Cart.
  Return: Fixnum(max possible cart items count)
=end
  def max_size
    Subscription.where(id: self.subscription_id).first.quantity
  end

=begin
  Description: Below method will find the current  capacity of a cart.
  Argument: an object of cart.
  Return: Fixnum(current total items count)
=end
  def current_size
    self.cart_items.count
  end

=begin
  Description: Below method will copy the lineitems of a order to a carts cart_item list.
  Argument : order_id
  Return: an object of cart(updated cart)
=end

  def copy_order_to_cart(order_id)
    order = Spree::Order.select('id, user_id, subscription_id, delivery_date, subscription_token').where(id: order_id).first

    order.line_items.each do |item|
      item.quantity.times do
          cart_item = self.cart_items.create(variant_id: item.variant_id, quantity: 1)
      end
    end

    self.update_attributes(user_id: order.user_id, subscription_id: order.subscription_id, delivery_date: order.delivery_date)

    order.subscription_token #here returning the subscription_token which will be assigned to session and used while subscrbing particular order.
  end

=begin
  Description: Following method will calculate the total number of items inside a Cart.
  Argument List: Object of Cart Class
  Return: total items count (Fixnum)
=end
  def total_items
    self.cart_items.count
  end

=begin
  Description: Following method will return the maximum possible cart items for current cart.
  Argument List: object of Cart(self)
  Return: Max possible cart items count for current Subscription type(Fixnum)
=end
  def max_cart_items
    self.update_column(:subscription_id, Subscription.first.id) if self.subscription_id.blank?
    Subscription.where(id: self.subscription_id).first.quantity
  end

=begin
  Description: Following action will fetch cartitems required attributes(variant_id, order_id, quantity) and assign them to cart_items hash.
  Argument: object of Cart Class(self)
  Return: hash containing required attributes(Hash)
=end
  def get_cart_items
    cart_items = {}
    cart_items[0] =CartItem.select('id, variant_id, order_id, quantity').where(cart_id: self.id)
    cart_items[0]
  end

=begin
Description: Following method will check subscription is full or not as per selected Subscription Type.
If subscription is full will return true else false.
Argument: object of Cart class(self)
Return: boolean
=end
  def is_full?
    self.total_items  == (Subscription.where(:id => self.subscription_id).first.try(:quantity) || 0)
  end

  def self.get_cart(user_id)
    inactive_carts =  Cart.where(user_id: user_id)
    inactive_carts.destroy_all
    Cart.new
  end

=begin
#Description: following action will copy the undelivered orders list into multiple carts and return that
cart array to calling controller action(here it's edit_snack_queue)
Argument: subscription object
Return: Returns the complete carts.
=end

  def self.create_carts_for_orders(subscription)

    #orders = subscription.orders.select('id, delivery_date').where('spree_orders.delivery_date > ?', Time.now).limit(3)
    permited_status = ['confirm', 'placed']
    orders = subscription.orders.select('id, delivery_date').where('spree_orders.state in (?)', permited_status).limit(3)

    snack_queue_cart = []

    self.clear_old_carts(subscription.user_id)

    orders.each_with_index do |order,count|
      @cart = Cart.new
      @cart.prepare_cart(subscription.user_id, subscription.id , order.delivery_date)
      @cart.copy_order_to_cart(order.id)
      snack_queue_cart[count] = @cart
    end
    snack_queue_cart
  end

=begin
  #Description: following method will clear out the already used carts from table.
  Argument List: user_id
  Return: nil
=end
  def self.clear_old_carts(user_id)
      Cart.where(user_id: user_id).destroy_all
  end


=begin
  Description: following method will fetch the cart ids which are needed to update orders/subscription
  after user has updated his cart items.
  Argument List: carts
  Return :cart_ids
=end

  def self.collect_cart_ids(carts)
    cart_ids = []

    carts.each do |cart|
      cart_ids.push(cart.id)
    end
    cart_ids #return the cart ids.
  end


=begin
  Description:  Below method will check all carts are full or not. basically method will loop around each around each
  cart and check whether its full or not. if all the carts are full then only method will return TRUE else FALSE will
  be returned.
  Argument: cart_ids
  Return: boolean
=end
  def self.is_carts_full?(cart_ids)
    result = true

    cart_ids.each do |cart_id|
      cart = Cart.where(id: cart_id).first
      result = result && cart.is_full?
    end
   result #return true if all the carts are full else false !
  end


=begin
  Description: Below action will get the line items of the order into an item_array.
  Argument: an object of cart(self)
  Return: item
=end
  def get_line_items_for_order
    items = self.cart_items.select('variant_id')
    item_array = []

    items.each do |item|
      item_array.push({:variant_id => item.variant_id })
    end

  end

  def self.get_my_incomplete_cart(user_id)
    all_carts = Cart.select('id, subscription_id, delivery_date').where(:user_id => user_id)

    all_carts.each do |cart|
      return cart unless cart.is_full?
    end
    nil #when all carts are full and there is no incomplete cart to return then return nil instead.
  end

  def get_snack_count
    self.current_size.to_s + " / " + self.max_size.to_s
  end

  def self.get_index(cart_id, user_id)
    self.count(:conditions => ['id < ? and user_id = ?', cart_id, user_id])
  end

  def carts_delivery_date
    self.delivery_date.strftime("%B %d, %Y")
  end

end