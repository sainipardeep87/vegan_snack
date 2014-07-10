class AddStatusToUserSubscriptions < ActiveRecord::Migration
  def change
    add_column :user_subscriptions, :status, :string, default: "active"
  end
end
