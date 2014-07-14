module MySubscriptionsHelper
=begin
    Description: method will check whether requested action type is of "pause" or not.
    Argument list: aciton_name
    Return: boolean
=end
  def is_pause?(action_name)
    action_name == 'pause'
  end

=begin
    Description: method will check whether requested action type is of "update" or not.
    Argument list: aciton_name
    Return: boolean
=end
  def is_update?(action_name)
    action_name == 'update'
  end

=begin
    Description: method will check whether requested action type is of "cancel" or not.
    Argument list: aciton_name
    Return: boolean
=end
  def is_cancel?(action_name)
    action_name == 'submit_cancel'
  end

=begin
    Description: method will check whether ther requested aciton belongs to any of pause/cancel.
    Argument list: aciton_name
    Return: boolean
=end
  def is_cancel_or_pause?(action_name)
    is_cancel?(action_name) || is_pause?(action_name)
  end

=begin
  Description: Method will check whether subscription eligible for unblock
  argument: subscription hash
   {:id=>293,:type=>"Basic Snack Pack",:delivery_date=>"July 14, 2014",:status=>"active", :is_blocked=>false}
  return: boolean
=end
  def unblock_subscription?(subscription)
    subscription[:status] == "paused" && subscription[:is_blocked] == true
    #false
  end

=begin
  Description: Method will check whether subscription eligible for resume
  argument: subscription hash
  {:id=>293,:type=>"Basic Snack Pack",:delivery_date=>"July 14, 2014",:status=>"active", :is_blocked=>false}
  return: boolean
=end
  def resume_subscription?(subscription)
    subscription[:status] == "paused" && subscription[:is_blocked] == false
    #true
  end

end