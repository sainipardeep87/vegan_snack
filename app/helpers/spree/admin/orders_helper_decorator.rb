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
            (delivery_date - ORDER_UPDATE_LIMIT.days).strftime("%m-%d-%Y")
        end

        def dynamic_file(start_date, end_date, ordered_on)
            "Vegan_order_summary_order_by_#{ordered_on}_#{start_date.strftime("%B_%d_%Y")}_to_#{end_date.strftime("%B_%d_%Y")}.xls"
        end
    end
  end
end