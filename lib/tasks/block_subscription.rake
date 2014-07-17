namespace :block_subscription do


    task :block_expired_subscriptions => :environment do

        puts "~~~~~2#block_expired_subscriptions_raketask~~~~~"
        #this returns the card_ids which are exipiring in current month hence we'll mark the associated subscrption_orders as blocked.
        expired_card_ids = Creditcard.expire_cards

        if expired_card_ids.blank?
            puts 'block_subscription###No cards to expire in current Month #block_subscription.rake 9th line'
        else
            puts 'block_subscription###Yes, we got to block following cards #block_subscription.rake 11th line'
            puts expired_card_ids
        end

        #those subscriptions will be blocked as associated creditcards have expired in current Month.
        if expired_card_ids.present?
            subscription_ids = Spree::Order.collect_user_subscription_ids_for_expired_cards(expired_card_ids)
            puts 'block_subscription ### Below Subscription Ids will be blocked'
            puts subscription_ids
        end

        customer_data =  UserSubscription.block_subscription_and_orders(subscription_ids)  if subscription_ids.present?

        if customer_data.present?
                customer_data.each do |data|
                    #result =VeganMailer.subscription_blocked_notification(data[:customer_name], data[:customer_email],
                    #data[:card_type], data[:card_expiry_date]).deliver
                    #puts 'blocked_subscription# 32 subscirption blocked completely'
                    #puts result
                end
       end

    end

end
