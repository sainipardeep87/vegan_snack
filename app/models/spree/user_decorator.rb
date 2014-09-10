Spree::User.class_eval do

  before_validation :clear_validations_on_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,  presence: {message:  "An email address must be entered."},
      format:  { with:  email_regex , message:  "The email address is not valid." },
      length: {maximum: 50, message: "Maximum 50 characters allowed." },
      uniqueness:  { case_sensitive: false, message: "Email ID already used."}

  validates :first_name, :if => :should_validate_name?,  presence: {message: "First name is required."},
      length: {maximum: 50, message: "Maximum 50 characters allowed."}

  validates :last_name, :if => :should_validate_name?, presence: {message: "Last name is required."},
      length: {maximum: 50, message: "Maximum 50 characters allowed."}

  validates :password, :if => :should_validate_password?,
      presence: { message: 'Password is required.'}, confirmation: true,
          length: {minimum: 6, message: "Please enter at least 6 characters." }

  validates :password_confirmation, :if => :should_validate_password?,
      presence: { message: "Password confirmation is required."},
      length: {minimum: 6, message: "Please enter at least 6 characters." }

  #Add new Attributes to user_attributes permission list.
  Spree::PermittedAttributes.user_attributes.push :addresses_attributes => [
      :firstname, :lastname, :address1, :address2,
      :city, :zipcode, :phone, :statename, :company ]

  Spree::PermittedAttributes.user_attributes.push :facebook_token

  has_many :addresses
  has_many :creditcards
  has_one :cart
  has_many :user_subscriptions
  has_many :subscriptions, through: :user_subscriptions, source: :subscription
  has_many :orders, through: :user_subscriptions, source: :orders
#start wizard code
 #attr_accessible :shipping_name, :billing_name, :employee_number, :first_name, :last_name, :middle_name
   attr_writer :current_step
  
  # validates_presence_of :shipping_name, :if => lambda { |o| o.current_step == "shipping" }
  # validates_presence_of :billing_name, :if => lambda { |o| o.current_step == "billing" }
  
  
=begin
  has_many :line_items
  has_many :orders, through: :line_items
=end


  # has_many :user_subscriptions
  # has_many :subscriptions, through: user_subscriptions, source: :subscription

  accepts_nested_attributes_for :addresses  #to Support nested attributes with User Details.
  accepts_nested_attributes_for :creditcards
  attr_accessor :updating_password, :sub_type, :updating_names, :coupon_code

  #below method will check entered Email ID format is valid or not ?
  def is_valid_email?
    self.valid?

    if self.errors.to_hash.has_key?(:email)
      self.remove_errormessages_added_by_spree
      self.errors.messages[:email][0]
    end

  end

=begin
  Description: Function will fetch the active subscriptions(subscription in active status and order in confirm state)
  argument list: nil
  return: user_subscription object
=end
  def active_subscriptions
    #self.user_subscriptions.includes([:subscription, :orders]).where('spree_orders.delivery_date > ? and user_subscriptions.status = ? ', Time.now, "active").uniq
    self.user_subscriptions.includes([:subscription, :orders]).where('spree_orders.state = ? and user_subscriptions.status = ? ', "confirm", "active").uniq
  end

=begin
  Description: Function will return the usersubscriptions with status "active"
  argument list: nil
  return: user_subscription objects.
=end
  def all_subscriptions
    #enable this one for the previous conditonal update of resume/pause functionality.
    #self.user_subscriptions.includes([:subscription, :orders]).where('user_subscriptions.status = ?', "active").uniq.order(:subscription_id)

    permited_status = ['confirm', 'placed']
    self.user_subscriptions.includes([:subscription, :orders]).where('spree_orders.state in (?)', permited_status).uniq.order(:subscription_id)
  end

=begin
  Description: Function will clear the incomplete address details as customer has left the payment method in inconsistent
  state hence there is not need of those incomplete orders.
  argument list: nil
  return: nil
=end
  def clear_incomplete_addresses
    self.addresses.where(:is_complete => false).destroy_all
  end

=begin
  Description: Following action will fetch the first undelivered order of each active subscription.
  Argument: nil
  Return: Array of hash (containging subscription id, type, delivery_date, status attributes)
=end
  def fetch_active_subscriptions

    permited_status = ['confirm','placed', 'paused']
    active_subscriptions= self.user_subscriptions.includes(:orders).where('spree_orders.state in (?)',permited_status)
    result = []

    active_subscriptions.each do |sub|
      unpermited_order_statuses = ['canceled', 'complete']
      first_order =  sub.orders.where('state not in (?)', unpermited_order_statuses).first

      result.push({
          id: sub.id,
          type: sub.subscription.subscription_type,
          #:delivery_date => sub.orders.where(state: "confirm").first.delivery_date.strftime("%B %d, %Y"),
          delivery_date: first_order.delivery_date.strftime("%B %d, %Y"),
          status: sub.status,
          #:status => first_order.state,
          is_blocked: sub.is_blocked
        })
    end
    result #return the final active subscription_orders result.
  end
=begin
  Description: function will fetch the undeleted & completed addresses only.
  Argument List: nil
  Return: nil
=end
  def get_addresses
    #check is_complete flag being false & during new subscription creation the is_complete flag is initially
    #set to false. if payment is done then only we are saving the address(by turning this flag to true),
    #if its an incomplete payment order then removing those orders from table.
    self.addresses.where(:is_deleted => false, :is_complete =>  true)
  end


#Description : Following method will perform conditional validation on password & password_confirmation (on update password only)
  def should_validate_password?
    #updating_password || new_record?
    updating_password
  end

  # Description: Following method will perform conditional validation on first name and last name of a user.
  def should_validate_name?
    updating_names
  end

  #Description: following action will remove the default error messages added by Spree.
  def remove_errormessages_added_by_spree

    self.errors.messages.each do |_,v|
      v.delete( "can't be blank" )
      v.delete("is invalid")
      v.delete("has already been taken")
      v.delete("is too short (minimum is 6 characters)")
    end

  end
=begin
  Description: Function will update the address types against the different type of addresses(billing/shipping)
  Argument List: nil
  Return: nil
=end
  def update_address_type_and_name_fields
   
    #If Sign up using FB, only one address is saved, no need to change address types
    if self.facebook_token.blank?
      self.addresses.first.update_attributes(address_type: SHIP)
      self.addresses.last.update_attributes(address_type: BILL)
    end

    self.update_attributes(first_name: self.addresses.first.first_name)
    
    self.update_attributes(last_name: self.addresses.first.last_name)
  end

=begin
  Description: following method will check entered email & password combination is found/not against Spree::User
  Argument: email, password
  return: boolean
=end

  def self.check_valid_user?(user_email, user_password)
    @user = Spree::User.where(email: user_email).first
    @user.blank? ? false : @user.valid_password?(user_password)
  end

=begin
Description: Following method will checked entered email ID during sign up process is registered with our app or not.
Argument: Email Parameter
return: boolean
=end

  def self.check_email_registered_with_vegan(submitted_email)
    Spree::User.exists?(email: submitted_email) #returns true if exists else false.
  end

=begin
Description: following method will copy the customer necessary fields from address table and assign it
to the @user section.
Argument List: an object of Spree::User class
Return: NIL
=end

  def update_bill_and_ship_address_details

    firstname = self.addresses.first.firstname
    lastname = self.addresses.first.lastname
    ship_address_id = self.addresses.first.id #first entered address details are of shipping details.
    bill_address_id =  self.addresses.last.id  #second entered address details are of billing details.
    self.update_attributes(first_name: firstname, last_name: lastname,
        bill_address_id: bill_address_id, ship_address_id: ship_address_id)
  end

  def push_subscription_and_customer_id(subscription_id, customer_id)
    self.update_attributes(subscription_id: subscription_id, braintree_customer_id: customer_id)
  end

=begin
Description: Following method will add our user/customer over Spree Hub.
Argument List: an object of Spree::User class
Return: nil
=end
  def add_customer_over_hub
    user_hash = self.attributes.slice("id", "first_name", "last_name", "email")
    bill_hash = self.billing_address.attributes.slice("id", "address1", "address2", "zipcode",
                                                      "city", "state_name", "country_id", "phone")
    customer = {"customer" => [user_hash], "billing_address" => [bill_hash]}
    result = Spree::Hub::Client.push(customer.to_json)

  end

=begin
  Description: Below method will clear all validation on Password Field if the user has been authenticated
  via facebook, which we can check by its facebook_token parameter. if its a normal user then regular validation
  on password will  be applicable.
  Argument: an object of Spree::User Class
  Return : nil
=end
  def clear_validations_on_password
    if self.facebook_token.present?
      _validators.reject!{ |key, value| key == :password }

      _validate_callbacks.each do |callback|
        callback.raw_filter.attributes.reject! {|key| key == :password } if callback.raw_filter.respond_to?(:attributes)
      end
    end
  end

 end