class AddSubscriptionIdToSpreeUsers < ActiveRecord::Migration
  def change
    add_column :spree_users, :subscription_id, :integer
  end
end
