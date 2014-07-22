module ApplicationHelper

=begin
Description: following action will redirect to desired location after signing out User from application.
Argument List : NIL
Return : NIL
=end
  def logo_navigation_path
    spree_current_user ? main_app.profile_users_path : spree.signup_path
  end

  def check_value i
    return true if i == 0
  end

  #below method will remove the error messages added by Spree.
  def remove_errormessages_added_by_spree

    self.errors.messages.each do |_,v|
      v.delete( "can't be blank" )
      v.delete("is invalid")
      v.delete("has already been taken")
      v.delete("is too short (minimum is 6 characters)")
    end
  end

=begin
  Description: Below method will prepare params which is needed to send the signup email notification to user.
  params list: order object.
  Return: result hash.
=end
  def signup_mail_params(order)

    subscription = Subscription.where(id: order.user_subscription.subscription_id).first

    result = {
        :email => spree_current_user.email,
        :fname => spree_current_user.first_name,
        :lname => spree_current_user.last_name,

        :order_no => order.number,
        :order_placed_date => order.created_at.to_date.to_s,
        :bill_name => order.billing_address.firstname + "  " + order.billing_address.lastname,
        :bill_phone => order.billing_address.phone,
        :bill_address => order.billing_address.address1 + " " + order.billing_address.address2,
        :bill_city => order.billing_address.city,
        :bill_state => order.billing_address.state_name,
        :bill_zip => order.billing_address.zipcode,

        :ship_name => order.shipping_address.firstname + "  " + order.shipping_address.lastname,
        :ship_phone => order.shipping_address.phone,
        :ship_address => order.shipping_address.address1 + " " + order.shipping_address.address2,
        :ship_city => order.shipping_address.city,
        :ship_state => order.shipping_address.state_name,
        :ship_zip => order.shipping_address.zipcode,

        :cc_name =>  order.creditcard.cc_holder_name,
        :cc_type => order.creditcard.cc_type,
        :cc_no =>   "XXXXXXXXXX" + order.creditcard.cc_part_2,

        :subscription_name => subscription.subscription_type,
        :subscription_count => 1,
        :subscription_price => subscription.plan_price.to_f,
        :handing_price => "0.00",
        :grand_total => subscription.plan_price.to_f,
        :sku => "BASIC"
    }

  end
=begin
  Description: Below method will prepare params for vendor Email functionality.
  params list: order object.
  Return: result hash.
=end
  def vendor_email_params(order)
    line_item_rows = ""
    vendor_email = vendor_name = ""
    order.reload.line_items

    order.line_items.each do |item|
      product = Spree::Product.where(:id => item.variant_id).first
      content = REXML::Document.new( view_context.product_image(product))
      snack_image =  content.get_elements("//img")[0].attribute('src')
      image_path = "https://www.vegansnackpacks.com"+snack_image.to_s

      vendor_email = item.product.vendor.email
      vendor_name  = item.product.vendor.name

      line_item_rows += '
      <tr><td><table align="center" border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1px solid #dedfdf" width="444">
      <tr><td height="17"/></tr><tr valign="top"><td width="83">
      </td><td width="221">
      <span style="font-size:12px;font-weight:normal;display:block;line-height:200%;"/><p style="margin-bottom: 4px;">' + item.name + '</p>
      </td><td style="text-align: right" width="140">' + item.quantity.to_s + '</td></tr><tr><td colspan="3" height="25"/>
      </tr></table><td></tr>'
    end

    result = {
      :line_item_rows => line_item_rows,
      :vendor_email =>  vendor_email,
      :vendor_name => vendor_name
    }

  end
=begin
  Description: Below method will prepare params which is needed  for Snack Queue Update.
  params list: order object.
  Return: result hash.
=end
  def queue_update_mail_params(order)

    line_item_rows  = ''

    order.line_items.each do |x|
      product = Spree::Product.where(:id => x.variant_id).first
      content = REXML::Document.new( view_context.product_image(product))
      snack_image =  content.get_elements("//img")[0].attribute('src')
      image_path = "https://www.vegansnackpacks.com"+snack_image.to_s

      line_item_rows += '
          <tr><td><table align="center" border="0" cellpadding="0" cellspacing="0" style="border-bottom: 1px solid #dedfdf" width="444">
          <tr><td height="17"/></tr><tr valign="top"><td width="83">
          <img src="'+ image_path +'" >
          </td><td width="221">
          <span style="font-size:12px;font-weight:normal;display:block;line-height:200%;"/><p style="margin-bottom: 4px;">' + x.name + '</p>
          </td><td style="text-align: right" width="140">' + x.quantity.to_s + '</td></tr><tr><td colspan="3" height="25"/>
          </tr></table><td></tr>'
    end

    result = {
        :email => spree_current_user.email,
        :fname => spree_current_user.first_name,
        :lname => spree_current_user.last_name,
        :line_item_rows => line_item_rows,
        :delivery_date =>   order.delivery_date.to_date.to_s
    }

  end
=begin
  Description: Below method will prepare params which is needed  for subscription update email notification.
  params list: subscription type.
  Return: result hash.
=end
  def subscription_update_mail_params(subscription_type)

    result = {
        :email => spree_current_user.email,
        :fname => spree_current_user.first_name,
        :lname => spree_current_user.last_name,
        :subscription_name => subscription_type
    }

  end
=begin
  Description: Below method will prepare params which is needed  For profile udpate Email.
  params list: subscription type.
  Return: result hash.
=end
  def profile_update_mail_params

    result = {
        :email => spree_current_user.email,
        :fname => spree_current_user.first_name,
        :lname => spree_current_user.last_name
    }

  end


=begin
  Description: Below method will prepare params which is needed  For forgot password.
  params list: subscription type.
  Return: result hash.
=end
  def get_forgot_password_params(url, user)
    result = {:url => url,
              :fname => user.first_name,
              :lname => user.last_name,
              :email => user.email
    }
  end

end