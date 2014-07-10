class AddResumedAtToUserSubscriptions < ActiveRecord::Migration
  def change
    #20140627075123
    add_column :user_subscriptions, :resumed_at, :datetime
  end
end
