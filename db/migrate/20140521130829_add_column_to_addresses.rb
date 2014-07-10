class AddColumnToAddresses < ActiveRecord::Migration
  def change
  	add_column :spree_addresses, :type, :string
  end
end
