class AddBraintreeTokenUpdatedToToUserSubscription < ActiveRecord::Migration
  def change
    add_column :user_subscriptions, :updated_to_id, :integer, :default => 0
    add_column :user_subscriptions, :braintree_token, :string

  end
end
