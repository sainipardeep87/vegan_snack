namespace :notification do

  task :notify_customer_and_admin => :environment do

    puts "##########~~~~~1#Notify_customer_and_admin_rake_task Running At : ~~~~~#################"
    puts Time.now

    card_ids = Creditcard.mark_expiring_cards
    customer_data = Spree::Order.collect_customer_emails_of_expiring_cards(card_ids)

    puts 'Following card ids have been marked is_expiring:'
    puts card_ids

    customer_data.each do |data|
        result = VeganMailer.card_expiry_notification_for_customer(
          data[:name], data[:email],data[:subscription_type], data[:delivery_date]).deliver
        puts result
    end

  end

end