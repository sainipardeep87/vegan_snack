namespace :block_subscription do


    task :block_expired_subscriptions => :environment do

        puts "~~~~~2#block_expired_subscriptions_raketask~~~~~"
        #this returns the card_ids which are exipiring in current month hence we'll mark the associated subscrption_orders as blocked.
        expired_card_ids = Creditcard.get_expired_cards

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

        if subscription_ids.present?
           subscription_data =  UserSubscription.block_subscription_and_orders(subscription_ids)
           puts subscription_data
           VeganMailer.subscription_blocked_notification(subscription_data[:email], subscription_data[:subscriptions_types]).deliver if subscription_data.present?
        end
    end

end
