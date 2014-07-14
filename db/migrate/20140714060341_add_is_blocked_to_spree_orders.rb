class AddIsBlockedToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :is_blocked, :boolean, default: false
  end
end
