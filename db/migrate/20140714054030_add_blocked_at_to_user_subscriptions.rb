class AddBlockedAtToUserSubscriptions < ActiveRecord::Migration
  def change
    add_column :user_subscriptions, :blocked_at, :datetime
  end
end
