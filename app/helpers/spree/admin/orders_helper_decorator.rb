module Spree
  module Admin
    module OrdersHelper
=begin
    Description: following helper method will calculate the lockdown time period which is exactly 7 days
    earlier to the delivery_date.. (ORDER_UPDATE_LIMIT = 7)
    arugment: delivery_date
    return: lockdown date
=end
        def lockdown_date(delivery_date)
            (delivery_date - ORDER_UPDATE_LIMIT.days).to_date
        end
    end
  end
end