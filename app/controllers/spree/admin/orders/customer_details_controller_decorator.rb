Spree::Admin::Orders::CustomerDetailsController.class_eval do
    include CustomerDetailsHelper

    def update
        #@order.bill_address.assign_attributes(order_params[:bill_address_attributes])
        #@order.ship_address.assign_attributes(order_params[:ship_address_attributes])

        if @order.update_attributes(order_params)
            @order.update_total_and_item_total
            flash[:success] = Spree.t('customer_details_updated')
            redirect_to admin_order_customer_path(@order)
        else
            @order.errors.messages.each do |_,v|
                v.delete( "can't be blank" )
            end
            render :action => :edit
        end
    end

end