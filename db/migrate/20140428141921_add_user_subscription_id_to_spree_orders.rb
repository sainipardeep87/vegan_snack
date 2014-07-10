class AddUserSubscriptionIdToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :user_subscription_id, :integer
  end
end
