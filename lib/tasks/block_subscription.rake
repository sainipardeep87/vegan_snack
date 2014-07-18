namespace :block_subscription do

  task :block_expired_subscriptions => :environment do

    puts "##############~~~~~2#block_expired_subscriptions_raketask~~~~~##############"

    #this returns the card_ids which are exipiring in current month hence we'll mark the associated subscrption_orders as blocked.
    expired_card_ids = Creditcard.expire_cards

    #those subscriptions will be blocked as associated creditcards have been expired in current Month.
    subscription_ids = Spree::Order.collect_user_subscription_ids_for_expired_cards(expired_card_ids) if expired_card_ids.present?

    customer_data =  UserSubscription.block_subscription_and_orders(subscription_ids)  if subscription_ids.present?

    customer_data.each do |data|
      result =VeganMailer.subscription_blocked_notification(data[:customer_name], data[:customer_email],
      data[:card_type], data[:card_expiry_date]).deliver

      #below puts lines only for debugging purpose.
      puts 'Following creditcards will be blocked : '
      puts expired_card_ids
      puts 'Below Subscription Ids will be blocked'
      puts subscription_ids
      puts 'card block email sent to following IDs.'
      puts result
    end

  end

end
