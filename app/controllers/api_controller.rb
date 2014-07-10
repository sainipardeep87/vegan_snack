class ApiController < ActionController::Base
  
=begin
Description: below action will call update the placed order in our store front database after we
get response from spree hub.
Argument: complete order params list.
Return: json response to hub.
=end
	def orders_placed
    request_id = params[:request_id]

    if params["order"].present?
      shipstation_order_id = params["order"]["shipstation_id"]
      order_number = params["order"]["id"]

      if shipstation_order_id.present?
        order_number = Spree::Order.order_placed(order_number, shipstation_order_id)
        render :json => {:status => 200,
                         :summary => "Order #{order_number} placed in Vegan store front #{shipstation_order_id}",
                         :request_id => request_id
        }.to_json

      else
        render :nothing => true
        #render :json => { :status => 500, :summary => "Shipstation Id is missing.", :request_id => request_id}.to_json
      end

    else
        render :json => { :status => 500, :summary => "Order is Missing.",:request_id => request_id }.to_json
    end

  end

=begin
Description: below action will add shipment to store front after getting response from hub.
Argument: complete order params list.
Return: json response to hub.
=end

  def add_shipments

    request_id = params[:request_id]
    shipment =  params["shipment"]

    if shipment.present?
      shipment_object =  Spree::Shipment.add_shipment(shipment)
      render :json =>  {:status => 200, :summary => "Shipment Added.", :request_id => request_id}.to_json
    else
      render :nothing => true
    end

  end

=begin
Description: below action will update shipment to store front after getting response from hub.
Argument: complete order params list.
Return: json response to hub.
=end
	def update_shipments
    request_id = params[:request_id]
		@shipments = Spree::Shipment.update_shipment(params)
    render json:  {:status => 200, :summary => "Shipment Updated.", :request_id => request_id}.to_json
	end

  def subscription_charged
    
     if request.get? #has come for verification.
    
      challenge = request.params["bt_challenge"]
      response = Braintree::WebhookNotification.verify(challenge)
      logger.info "verified configured webhook subscription_charged!"
      
      respond_to do |format|
        format.xml {render xml:response and return }
      end

     else  #coming for post.
      
      begin
        result = Braintree::WebhookNotification.parse(
           request.params["bt_signature"],
           request.params["bt_payload"]
           )
        logger.info "[Webhook Received #{result.timestamp}] Kind: #{result.kind} | Subscription: #{result.subscription.id}"

        if result.present?
          result_type = result.kind
          braintree_subscription_id = result.subscription.id
          Spree::Order.mark_order_paid(braintree_subscription_id) if result_type == SUBSCRIPTION_SUCCESS
          #once payment is done, pushing the order as well.
        logger.info 'Subscription successfully charged!'
         Spree::Order.push_paid_order_to_hub
        end

        rescue  Exception => error
          logger.error "Some error occured while charging subscription" + error.to_s
        end

      end #end of if else.

      render nothing: true
  end

  def subscription_charge_error

    if request.get?
      logger.info "going to verify the subscription charge error api method"
      challenge = request.params["bt_challenge"]
      challenge_response = Braintree::WebhookNotification.verify(challenge)

      respond_to do |format|
        format.xml {render xml:challenge_response}
      end
    
    else #will be added later

    end

  end

end