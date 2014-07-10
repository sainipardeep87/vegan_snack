namespace :push_order_to_hub do

	task :push_order => :environment do
=begin    
Comment:
#Currently our order is pushed to hub after the payment is done inside the api_controller/subscription_charged
#hence for now commenting this section.

		@orders = Spree::Order.where("is_pushed = ? AND state = ? AND payment_state = ? ", false, 'confirm', 'paid')

		current_date = (Time.now + HUB_PUSH_LIMIT.days).strftime('%m-%d-%y')


    #HUB_PUSH_LIMIT=7, delivery_date: 11th june, placed on: 1st june, should be pushed to hub on 4th june,
    #if current day is 4th june, then current_date = 4th june+7(hub push limit) which is 11th june, so
    #order_delivery_date == current_date. hence order will be placed over hub.


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

          puts 'pushed orders info id = '+ order.id.to_s + ' number = '+ order.number
          puts 'newly created orders number is  '+ new_one.number
        else
         puts "Sorry, there is some error in hub push, please wait!"
       end
      end

    end
    #just to track whether this task is running successfully or not.
    puts "Push order is running " + Time.now.to_s

=end
	end

end