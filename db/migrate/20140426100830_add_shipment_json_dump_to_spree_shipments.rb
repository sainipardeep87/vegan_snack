class AddShipmentJsonDumpToSpreeShipments < ActiveRecord::Migration
  def change
    add_column :spree_shipments, :shipment_json_dump, :text
  end
end
