class VeganMailer < MandrillMailer::TemplateMailer

  default :from => 'noreply@ahimsacusine.com'

=begin
  Description: Below method will send Signup Email notification to User.
Argument List: data hash(containing all required parameters for email notification)
Return: nil
=end
  def signup_email(data)

    mandrill_mail :template => 'vegan_signup',
        :subject => "Vegan Signup",
        :to => {
            :email => data[:email],
            :name => data[:fname]+ " "+ data[:lname]
        },
        :vars => {
        'FNAME' => data[:fname],
        'LNAME' => data[:lname],
        'ORDER_NO' => data[:order_no],
        'ORDER_PLACED_DATE'=> data[:order_placed_date],
        'BILL_NAME' => data[:bill_name],
        'BILL_PHONE' => data[:bill_phone],
        'BILL_ADDRESS'=> data[:bill_address],
        'BILL_CITY' => data[:bill_city],
        'BILL_STATE'=> data[:bill_state],
        'BILL_ZIP'=> data[:bill_zip],
        'SHIP_NAME' => data[:ship_name],
        'SHIP_PHONE' => data[:ship_phone],
        'SHIP_ADDRESS' => data[:ship_address],
        'SHIP_CITY' => data[:ship_city],
        'SHIP_STATE'=> data[:ship_state],
        'SHIP_ZIP' => data[:ship_zip],

        'CC_NAME'=>  data[:cc_name],
        'CC_TYPE' => data[:cc_type],
        'CC_NO'=>  data[:cc_no],

        'SUBSCRIPTION_NAME' => data[:subscription_name],
        'SUBSCRIPTION_COUNT' => data[:subscription_count],
        'SUBSCRIPTION_PRICE' => data[:subscription_price],
        'HANDLING_PRICE' => data[:handing_price],
        'GRAND_TOTAL' => data[:grand_total],
        'SKU' => data[:sku]
        },
        :important => true,
        :inline_css => true
  end

=begin
  Description: Below method will send the vendor notification to associated vendors.
Argument List: data hash(containing all required parameters for email notification)
Return: nil
=end

  def vendor_email(data)

    mandrill_mail :template => 'order_confirmation_vendors',
                :subject => "Your Product added to Order",
                  :to => {
                    :email => data[:vendor_email],
                    :name =>  data[:vendor_name]
                  },
                  :vars => {
                    'VENDOR' => data[:vendor_name],
                    'LINE_ITEM_ROWS' => data[:line_item_rows]
                  },
                  :important => true,
                  :inline_css => true
  end

=begin
  Description: Below method will send  Snack Queue Update Email Notification.
Argument List: data hash(containing all required parameters for email notification)
Return: nil
=end
  def snack_queue_update_mail(data)

    mandrill_mail :template => 'update_queue',
                  :subject => "Snack Queue Updated",
                  :to => {
                      :email => data[:email],
                      :name =>  data[:fname]+ " "+ data[:lname]
                  },
                  :vars => {
                      'FNAME' => data[:fname],
                      'LNAME' => data[:lname],
                      'DELIVERY_DATE' => data[:delivery_date],
                      'LINE_ITEM_ROWS' => data[:line_item_rows]

                  },
                  :important => true,
                  :inline_css => true

  end

=begin
  Description: Below method will send  New Subscription Created Email Notification.
  Argument List: data hash(containing all required parameters for email notification)
  Return: nil
=end
  def new_subscription_mail(data)

    mandrill_mail :template => 'new_subscription',
                  :subject => "New Subscription",
                  :to => {
                      :email => data[:email],
                      :name =>  data[:fname]+ " "+ data[:lname]
                  },

                  :vars => {
                      'FNAME' => data[:fname],
                      'LNAME' => data[:lname],
                      'ORDER_NO' => data[:order_no],
                      'ORDER_PLACED_DATE'=> data[:order_placed_date],
                      'BILL_NAME' => data[:bill_name],
                      'BILL_PHONE' => data[:bill_phone],
                      'BILL_ADDRESS'=> data[:bill_address],
                      'BILL_CITY' => data[:bill_city],
                      'BILL_STATE'=> data[:bill_state],
                      'BILL_ZIP'=> data[:bill_zip],

                      'SHIP_NAME' => data[:ship_name],
                      'SHIP_PHONE' => data[:ship_phone],
                      'SHIP_ADDRESS' => data[:ship_address],
                      'SHIP_CITY' => data[:ship_city],
                      'SHIP_STATE'=> data[:ship_state],
                      'SHIP_ZIP' => data[:ship_zip],

                      'CC_NAME'=>  data[:cc_name],
                      'CC_TYPE' => data[:cc_type],
                      'CC_NO'=>  data[:cc_no],

                      'SUBSCRIPTION_NAME' => data[:subscription_name],
                      'SUBSCRIPTION_COUNT' => data[:subscription_count],
                      'SUBSCRIPTION_PRICE' => data[:subscription_price],
                      'HANDLING_PRICE' => data[:handing_price],
                      'GRAND_TOTAL' => data[:grand_total],
                      'SKU' => data[:sku]

                  },
                  :important => true,
                  :inline_css => true

  end

=begin
  Description: Below method will send Email Notification to user When a particular Subscription is being updated.
  Argument List: data hash(containing all required parameters for email notification)
  Return: nil
=end
  def update_subscription_email(data)

    mandrill_mail :template => 'update_subscription',
                  :subject => "Subscription Updated",
                  :to => {
                      :email => data[:email],
                      :name => data[:fname]+ " "+ data[:lname]
                  },

                  :vars => {
                      'SUBSCRIPTION_NAME' => data[:subscription_name]
                  }
  end

=begin
  Description: Below method will send Email Notification to user when his/her account details are updated.
  Argument List: data hash(containing all required parameters for email notification)
  Return: nil
=end

  def profile_update_email(data)

    mandrill_mail :template => 'account_update',
                  :subject => "Account Updated",
                  :to => {
                      :email => data[:email],
                      :name => data[:fname]+ " "+ data[:lname]
                  }
  end

=begin
Description: Below method will send Email Notification to user when his/her account details are updated.
Argument List: data hash(containing all required parameters for email notification)
Return: nil
=end
  def forgotpassword_email(data)

    mandrill_mail :template => "forgot_password",
                  :subject => 'Forgot Password?',
                  :to => {
                      :email => data[:email],
                      :name => data[:fname] + "  " + data[:lname]
                  },
                  :vars => {
                    'FNAME' => data[:fname],
                    'LNAME' => data[:lname],
                    'LINK' => data[:url]
                  }
  end
=begin
 subscription_id: order.user_subscription_id,
        email: order.email,
        subscription_type: order.user_subscription.subscription.subscription_type,
        delivery_date: order.delivery_date.strftime("%B %d, %Y")
=end
  def card_expiry_notification_for_customer(customer_name, customer_email, subscription_type, delivery_date)
    mandrill_mail :template => 'notify_customer',
      :subject => 'Your Credicard is expiring soon',

      :to => {
        :email => customer_email,
        :name =>customer_name
      },
      :vars => {
        'FNAME'=> customer_name,
        'SUBSCRIPTION_TYPE' => subscription_type,
        'DELIVERY_DATE' => delivery_date
      }
  end



  def subscription_blocked_notification(customer_name, customer_email, card_type, card_expiry_date)
    mandrill_mail :template => 'block_notification',
    :subject => 'Trouble in snack land',
    :to => {
      :email => customer_email,
      :name => customer_name
    },
    :vars => {
      'NAME' => customer_name, #albert
      'CARD_TYPE' => card_type, #visa
      'CARD_EXPIRY_DATE' => card_expiry_date, #08/2014
    }

  end

end