class Creditcard < ActiveRecord::Base

  belongs_to :user
  has_many :orders, :class_name => 'Spree::Order'

  attr_accessor  :cardholder_name, :card_no, :cvv, :month, :year

  validates :cardholder_name, presence: {message: 'Name is mandatory.'},
      length: {maximum: 50, message: 'Name is too long.'}

  validates :card_no,presence: {message: 'Card no is mandatory.'},
      numericality:  {only_integer: true, message: "Invalid Card no. Entered."}
      #length: {minimum: 16, maximum: 25, message: "Invalid Card no. Entered."}

  validates :cvv, presence: {message: "CVV is mandatory."},
    numericality: {only_integer: true, message: "Invalid CVV Entered."},
    length: {minimum: 3, maximum: 5, message: "Invalid CVV Entered."}

  validates :month, presence: { message: 'This field is required.'}
  validates :year, presence: {message: 'This field is required.'}

  validate :card_valid_for_next_3_months?,  if: :should_check_for_card_expiry?

  #below validation will check whether the credit card is valid for upcoming 3 months or not.
  def card_valid_for_next_3_months?

    begin
      expire_date = Date.parse(self.year + '-' + self.month + '-' + Time.now.day.to_s)
      current_date = Date.today
      validity = expire_date - current_date

      errors.add(:year, "Sorry, Invalid Expire year/month selected") if validity.to_i < 0
      errors.add(:year, "Sorry, your card expiring in  next 3 months!") if validity.to_i > 0 && validity.to_i < 90
    rescue
      errors.add(:year, "Sorry, Invalid Expire year/month selected")
    end
  end

 #added conditional validation to check for card expiry only if user has entered a valid year/month from list.
  def should_check_for_card_expiry?
    self.month.present? && self.year.present?
  end

=begin
  Description: Following method will create a customer account over Braintree. Mostly we will be requiring  below
  mentioned parameters for creating a new customer ID over Braintree. With success of this function, we'll get a
  unique customer_id which will be used for further transcation with Braintree gateway.
  Argument List: fname, lname, comapny, email, phone
  Return Parameter: customer.id
=end

	def self.create_customer_over_braintree(fname, lname, company, email, phone )

		result = Braintree::Customer.create(
		    :first_name => fname,
		    :last_name =>lname,
		    :company => company,
		    :email => email,
		    :phone => phone
		)
		result.customer.id

	end
  
=begin
  Description: Following method will create both customer and creditcard info over braintree .
  Argument List: address(contains firstname, lastname, company), email,card(card holder name, card_no, cvv,month,year)
  Return: object params returned by braintree(on success), false object(on failure)

=end
  def self.create_customer_and_creditcard_over_braintree(address, customer_email, card)

 
    begin
      Braintree::Customer.create(
        :first_name => address.firstname,
        :last_name => address.lastname,
        :company => address.company,
        :email => customer_email,
        :credit_card => {
            :cardholder_name => card[:cardholder_name],
            :number => card[:card_no],
            :cvv => card[:cvv],
            :expiration_date => card[:month] + "/" + card[:year],
            :options => {
                :verify_card => true
            }
        }
      )
    rescue
      #if some other error occurred because of which braintree could not return any value then false will returned
      #errors like braintree server down, no response from braintree any such failures.
      OpenStruct.new(:success? => false)
    end
  end

=begin
Description: Following method will create the credit card details over Braintree.
Argument LIst : braintree_customer_id, card(holds cardholder_name, card_no, cvv,month, year)
Return: object returned by braintree(success), error object(On failure)
=end
    def self.create_only_creditcard_over_braintree(customer_id, card)

    begin
       Braintree::CreditCard.create(
          :customer_id => customer_id,
          :cardholder_name => card.cardholder_name,
          :number => card.card_no,
          :cvv => card.cvv,
          :expiration_date => card.month + "/" + card.year,
          :options => {
              :verify_card => true
          }
      )

      rescue => error
        logger.info "some error occured  "+ error.to_s
        OpenStruct.new(:success? => false)
    end
  end

=begin
  Description: Following method will save credit card details(returned by braintree api call) locally,
  which we will be using in our application rather than
  hitting API always.
  Argument: credit_card_public_details, default_card(boolean)
  Return: Creditcard object (saved one)
=end
  def self.save_credit_card_returns_local(credit_card, user_id)
    
      card = Creditcard.new(
          :token => credit_card.token,
          :customer_id => credit_card.customer_id,
          :cc_part_1 => credit_card.bin,
          :cc_part_2 => credit_card.last_4,
          :cc_type => credit_card.card_type,
          :cc_holder_name => credit_card.cardholder_name,
          :expiration_month => credit_card.expiration_month,
          :expiration_year => credit_card.expiration_year,
          :default => credit_card.default?,
          :user_id => user_id
      )

      card.save(:validate => false)
      card #return the card.

  end

=begin
 Description: as card is already created by default when @user.save is getting called while creating a new user,
hence currently we are just updating those over the existing creditcards
=end

  def self.update_creditcard(credit_card, user_id)

    card = Creditcard.where(user_id: user_id).last
    #We will be updating the creditcard details which was last created by the logged in User.
    #cc was created in creditcards_controller, add_card_complete_payment action.

      card.token = credit_card.token
      card.customer_id = credit_card.customer_id
      card.cc_part_1 = credit_card.bin
      card.cc_part_2= credit_card.last_4
      card.cc_type =credit_card.card_type
      card.cc_holder_name = credit_card.cardholder_name
      card.expiration_month = credit_card.expiration_month
      card.expiration_year = credit_card.expiration_year
      card.default = credit_card.default?

      card.save(:validate => false)
      card

  end

=begin
  Description: Following method will return authentication token of the creditcard to which customer
  has set as his default credit card. Along with customer Id, we'll select only the credit card which is
  default set by user.
  Argument List: customer_id
  Return List: token
=end
  def self.get_payment_token(customer_id)
    Creditcard.where(customer_id: customer_id, default: true).first.token
  end
  #Description: method will return the token value of the chosen card.
  def self.get_token(card_id)
    Creditcard.where(id: card_id).first.token
  end

end