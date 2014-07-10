 module UserRegistrationsHelper

=begin
     Description: Below helper method will merge subscription type(string) with the price of the subscription
     & return it to registration page.
     Return: String.
=end
   def show_plan_name_and_price(subscription)
     subscription[:subscription_type] + " - $" + number_with_precision(subscription[:plan_price], :precision => 2)
   end

=begin
  Description: Below helper method will check whether user is ordinary user or fb authenticatd user by checking
  the facebook_token present against user.
  Argument: facebook_token
  Return: boolean.
=end
    def is_ordinary_user?(facebook_token)
      facebook_token.blank?
    end

  end
