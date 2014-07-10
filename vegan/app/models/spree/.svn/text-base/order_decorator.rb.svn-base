Spree::Order.class_eval do
 
   after_update :add_order_message_to_hub

   ##########################################
   # Description: Below Method passes a order:new Notification Message to Spree Hub with order_number & order_channel Attributes
   # Argument: NIL
   # Return: NIL
   ##########################################

    def add_order_message_to_hub

		  unless completed_at.nil?

        new_order = Spree::Order.select('number AS ORDER_NUMBER,  channel AS COMMUNICATION_CHANNEL').where(:id => Spree::Order.last.id)
       	url = "http://staging.hub.spreecommerce.com/api/stores/52eb347f755b1c97e900001e/messages"

        data = {
  					:message =>  "order:new",
  					:payload => {
						:order =>{
  						:number => new_order.first.ORDER_NUMBER,
  						:channel => new_order.first.COMMUNICATION_CHANNEL,
  						}
				  }
			  }
        
        data = data.to_json

  	    RestClient.post(url, data, :content_type => :json, "X-Augury-Token" => "UjjKsdxbrwjpAPx9Hiw4") do |response, request, result|

            if response.code == 201
             		puts 'Just placed New Order to Spree Hub #{new_order.first.ORDER_NUMBER}'
          	else
             		puts response
          	end
        end #End of the RestClient.post Method

     	end # End of the unless Condition where completed_at is checked.

 	  end # End of the add_order_messsage_to_hub method.

end # End of the  Spree::Order Class