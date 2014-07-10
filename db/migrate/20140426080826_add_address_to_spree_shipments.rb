class AddAddressToSpreeShipments < ActiveRecord::Migration
  def change
    add_column :spree_shipments, :address, :text
  end
end
