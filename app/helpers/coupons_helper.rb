module CouponsHelper

=begin
Description: Below helpermethod will check whether the coupon params(code, discount name, discount_id
, amount) are modified or not, if modified then only it will create the new_coupon & mark the old
one as deleted. else no new coupon will be created.
=end
	def is_changed_coupon?(old_coupon, new_coupon)
		result = old_coupon.attributes.slice('coupon_code', 'discount_name', 'braintree_discount_id', 'discount_rate').to_a - 
			new_coupon.attributes.slice('coupon_code', 'discount_name', 'braintree_discount_id', 'discount_rate').to_a
		result.present?
	end

end