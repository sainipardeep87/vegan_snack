class AddIsDeletedToSpreeAddresses < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :is_deleted, :boolean, default: false
  end
end
