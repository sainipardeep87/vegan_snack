class AddSubscriptionTypeToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :subscription_type, :string
  end
end
