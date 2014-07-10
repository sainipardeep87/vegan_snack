class AddSubscriptionTokenToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :subscription_token, :string
  end
end
