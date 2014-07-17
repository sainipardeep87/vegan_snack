namespace :notification do

    task :notify_customer_and_admin => :environment do

        puts "~~~~~1#Notify_customer_and_admin_rake_task~~~~~"
        card_ids = Creditcard.mark_expiring_cards
        customer_data = Spree::Order.collect_customer_emails_of_expiring_cards(card_ids)

        admin_email_id = Spree::User.admin.first.email
        customer_email_ids = []

        customer_data.each do |customer|
            customer_email_ids.push customer[:email]
        end
        puts 'notify_customer_and_admin ## the card ids which we have marked is_expiring'
        puts card_ids
        puts '*********************************Task is running at time****************************** '
        puts Time.now

        if customer_data.present?
            customer_data.each do |data|

                result = VeganMailer.card_expiry_notification_for_customer(data[:name], data[:email], data[:card_type], data[:card_expiry]).deliver
                puts result
            end
        end
        if customer_email_ids.present?
            #only sending Email notification to customer, hence disabled below one.
            #result = VeganMailer.card_expiry_notification_for_admin(customer_email_ids.to_s, admin_email_id).deliver
        end

    end

end