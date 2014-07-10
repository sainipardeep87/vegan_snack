# run this seed file by rake db:seed:subscription_seed

subscription_list = [ 
	[ 5, "Small", "vegan_small_pack", 50.00],
	[10, "Medium", "vegan_medium_pack", 100.00],
	[20, "Large", "vegan_large_pack", 200.00]
]


subscription_list.each do |quantity, subscription_type, plan_id, price|
	Subscription.create(quantity: quantity, subscription_type: subscription_type, plan_id: plan_id, plan_price: price)
end