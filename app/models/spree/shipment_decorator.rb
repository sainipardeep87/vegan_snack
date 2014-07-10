Spree::Shipment.class_eval do

=begin
  Description: below method will add the shipment record in our store front db after getting response from hub.
  Argument List: params list
  Return: shipment object.
{"id"=>"25157803", "tracking"=>"760291015038446", "order_id"=>"37916077"}
=end

=begin
#we are not getting those all parameters hence commented this part for now.
#on basis of coming parameter using the below create call to add a shipment record.
        shipment =  Spree::Shipment.create(
              :number => data["shipment"]["id"],
              :tracking => data["shipment"]["tracking"],
              :shipstation_order_id => order.shipstation_order_id,
              :shipped_at => data["shipment"]["shipped_at"],
              :order_id => order.id,
              :state => data["shipment"]["status"],
              :address => data["shipment"]["shipping_address"],
              :shipment_json_dump => data
          )
=end

	def self.add_shipment(shipment)

      begin
  			if shipment.present?
          order = Spree::Order.where(:shipstation_order_id => shipment["order_id"]).first

          if order.present?
            shipment_object = Spree::Shipment.create(
              :number =>   shipment["id"],
              :tracking => shipment["tracking"],
              :address_id => order.ship_address_id,
              :order_id => order.id,
              :cost => order.total,
              :shipstation_order_id => shipment["order_id"],
              :shipment_json_dump => shipment
            )
            #order.update_columns(:state => "complete", :shipment_state => "shipped", :completed_at => Time.now )
            order.assign_attributes(state: "complete", shipment_state: "shipped", completed_at: Time.now)
            order.save(validate: false)
            order.update_total_and_item_total
          else
            logger.info "Sorry, shipstation_order_id is missing hence shipment cant be created!"
          end
  			end

      rescue
        logger.info "Some Error Occured";
      end
	end

=begin
  Description: below method will update the shipment record in our store front db.
  Argument List: params list
  Return: shipment object.
=end
	def self.update_shipment(params)
		begin
			data = JSON.parse(params)
			unless data.blank?
				shipment = Spree::Shipment.where(:number => data["id"]).first
				if shipment.present?
					# TODO currently the address response is dumped in a single field if future we will use
					# the address_id if needed.
					shipment.update_arrtibutes(:tracking => data["tracking"],
							                       :shipped_at => data["shipped_at"],
							                       :state => data["status"],
							                       :address => data["shipping_address"],
							                       :shipment_json_dump => data
																		)
				end
			end

		rescue

		end
	end

end