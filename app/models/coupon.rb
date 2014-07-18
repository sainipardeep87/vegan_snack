class Coupon < ActiveRecord::Base

 has_many :user_subscriptions
 has_many :orders, class_name: 'Spree::Order', foreign_key: 'coupon_id'


  validates_presence_of :coupon_code, :discount_name,
  	:braintree_discount_id,:discount_rate, message: "Mandatory Field."

  validates_numericality_of :discount_rate, greater_than: 0, less_than_or_equal_to: 100,
  	message: "Discount rate can be maximum 100%."

  validates_length_of :coupon_code, :discount_name, :braintree_discount_id,
  	:discount_rate, maximum: 40, message: "Maximum 40 Characters Allowed."

	#validate :check_discount_id_present?, if: :should_validate?
	validate :check_discount_id_present? , if: :should_validate?
	validate :coupon_code_taken?, if: "self.coupon_code.present?" && "self.validate_couponcode.present?"

	before_validation :strip_input_fields

	attr_accessor :validate_couponcode

	#strip all input text fields before validating or before saving.
	def strip_input_fields
		self.attributes.each do |key, value|
  			self[key] = value.strip if value.respond_to?("strip")
  		end
	end

	#will check for validation if its a new record.
	def should_validate?
		#self.new_record? && self.braintree_discount_id.present?
		self.braintree_discount_id.present?
	end

	#will check braintree fetched discount_ids present in local or not, if not then validate that object.
 	def check_discount_id_present?
 		all_discounts = Coupon.fetch_braintree_discounts
 		key_found = all_discounts.has_key?(self.braintree_discount_id)
 		errors.add(:braintree_discount_id, "Sorry,Discount token removed from Braintree.") unless key_found
 	end

 	#will validate the duplicacy of coupon code, if its already taken.
 	def coupon_code_taken?
 		#coupon_found = Coupon.where('coupon_code like BINARY ?', self.coupon_code).first.present?
 		#binding.pry
 		coupon_found = Coupon.where('coupon_code like BINARY ? and deleted = ?', self.coupon_code, false).first.present?
 		errors.add(:coupon_code, "Sorry, Coupon code  already in use.") if coupon_found
 	end

=begin
 Description: Below function will calculate the final amount after discount on the chosen coupon code.
 Argument List: coupon_code, plan_price
 return: hash object (braintree_discount_id, amount)
=end

	def self.get_briantree_discount_id_and_calculate_final_amount(plan_price, coupon_code)
		coupon = Coupon.select('id, braintree_discount_id, discount_rate as amount').where(coupon_code: coupon_code, deleted: false).first
 		coupon.amount  = ((coupon.amount / 100.00) * plan_price).to_f.round(2) if coupon.present?
 		coupon.respond_to?('attributes') ? coupon.attributes : nil
	end

=begin
Description: below function will increment the counter value when a particular coupon is being used
in any subscriptoin.
argument list : coupon_id (which will be updated)
=end
	def self.raise_counter(coupon_id)
		coupon = Coupon.where(id: coupon_id, deleted: false).first
		coupon.update_column(:counter, coupon.counter + 1) if coupon.present?
	end

=begin
	Description: Below function will check whether entered coupon code is valid or not.
	This check will consider only the undeleted(deleted: false) coupons only.
	Argument List: coupon_code(which user has entered during signup process)
	return: object(if its a valid coupon) else nil
=end
	def self.is_valid?(code)
		self.where('coupon_code like BINARY ? AND deleted =  ?', code, false).first
	end


#Description: Function will generate unique coupon code and check with existing coupon codes(avoid duplicate).
	def self.generate_unique_code
		existing_coupon = true

		while existing_coupon
			new_coupon = COUPON_INIT+"#{Array.new(3){rand(9)}.join}#{(0...3).map { (65 + rand(26)).chr }.join}"
			existing_coupon = self.where(coupon_code: new_coupon).first
		end
		new_coupon
	end

=begin
	Description: Function will fetch the existing discount plans(set over Braintree)and make them visible
	in the dropdown list(admin panel during new/edit coupon code)
	Argument List: NIL
	Return: hash containing all the discount plans.
=end
	def self.fetch_braintree_discounts
		result = {}
		begin
 			discounts = Braintree::Discount.all

 			if discounts.present?
 				discounts.each_with_index do |discount, index|
 					result.merge!({discount.id => index.to_s })
 				end
 			end
 		result #returning the final result here.

		rescue  Exception => error
			logger.error "Some Error in fetching braintree discounts"+ error.to_s
			OpenStruct.new(:success? => false)
		end
	end

#Description: Function will set the discount plan(vegan_small_plan) against the numeric value against the
#selected dropdown value.
	def set_discount_ID
		@discounts = Coupon.fetch_braintree_discounts
		#@discounts.select{|key, value| value == self.braintree_discount_id}
		discount_id = @discounts.key(self.braintree_discount_id)
		self.braintree_discount_id =  discount_id
	end

=begin
	Description: Following method will clear the invalid/braintree deleted discountIds from local DB.
	Argument List: valid_discount_ids
	Return: nil
=end
	def self.clear_braintree_removed_discounts_from_local(valid_discount_ids)
		invalid_coupons = self.select('id, deleted').where('braintree_discount_id NOT IN (?) and  deleted = ?', valid_discount_ids, false)
		invalid_coupons.update_all(deleted: true) if invalid_coupons.present?
	end

=begin
	Description: below method will fetch a message considering the coupon code is valid / invalid and respective message
	will be returned to the calling method.
	argument list: final_price
	reutrn: proper message as per valid/invalid coupon.
=end
  def price_with_coupon(final_price)
  	valid_coupon = Coupon.is_valid?(self.coupon_code)
  	coupon_price = final_price -((valid_coupon.discount_rate / 100.00) * final_price).round(2)  if valid_coupon.present?
	message = coupon_price.present? ? "You will be charged $#{coupon_price} for the first order and rest orders will be charged $ #{final_price}/month." : "Your coupon #{self.coupon_code} has expired. You will be charged $#{final_price}/month for this subscription."
  end

end