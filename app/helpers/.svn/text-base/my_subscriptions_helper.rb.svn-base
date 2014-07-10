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

end