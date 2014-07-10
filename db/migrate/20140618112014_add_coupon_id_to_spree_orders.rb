class AddCouponIdToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :coupon_id, :integer
  end
end
