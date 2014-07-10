class AddAddressTypeToAddresses < ActiveRecord::Migration
  def change
  	add_column :spree_addresses, :address_type, :string
  end
end
