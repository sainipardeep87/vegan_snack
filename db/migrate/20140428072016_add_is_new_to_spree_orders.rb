class AddIsNewToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :is_new, :boolean
  end
end
