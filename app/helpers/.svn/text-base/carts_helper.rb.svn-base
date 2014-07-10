module CartsHelper

=begin
  Description: Below method will check whether particular order row/cart will
  be delivered after the update date limit or not.
  Argument: delivery_date
  Return: boolean.
=end

  def delivery_after_a_week?(delivery_date)
    delivery_date.to_date > ORDER_UPDATE_LIMIT.days.from_now.to_date && delivery_date > Time.now
  end

=begin
  Description: Below method will check whether particular order row/cart is delivered or not.
  Argument: delivery_date
  Return: boolean.
=end
  def already_delivered? (delivery_date)
    delivery_date < Time.now
  end

=begin
    Description: Below method will check whether particular order row/cart will be delivered
     in coming 7 days or not.
    Argument: delivery_date
    Return: boolean.
=end

  def delivery_a_week_left?(delivery_date)
    delivery_date.to_date <= ORDER_UPDATE_LIMIT.days.from_now.to_date && delivery_date > Time.now
  end

end