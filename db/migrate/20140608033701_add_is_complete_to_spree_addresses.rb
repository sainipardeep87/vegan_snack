class AddIsCompleteToSpreeAddresses < ActiveRecord::Migration
  def change
    add_column :spree_addresses, :is_complete, :boolean, :default => true
  end
end
