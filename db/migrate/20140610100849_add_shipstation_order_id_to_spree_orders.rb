class AddShipstationOrderIdToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :shipstation_order_id, :string
  end
end
