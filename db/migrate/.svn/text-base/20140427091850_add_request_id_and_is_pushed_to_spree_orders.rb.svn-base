class AddRequestIdAndIsPushedToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :request_id, :string
    add_column :spree_orders, :is_pushed, :boolean, :default => false
  end
end
