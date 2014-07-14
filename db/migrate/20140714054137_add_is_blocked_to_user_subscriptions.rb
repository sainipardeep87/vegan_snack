class AddIsBlockedToUserSubscriptions < ActiveRecord::Migration
  def change
    add_column :user_subscriptions, :is_blocked, :boolean, default: false
  end
end
