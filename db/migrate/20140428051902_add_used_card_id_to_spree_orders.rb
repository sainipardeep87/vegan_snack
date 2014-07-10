class AddUsedCardIdToSpreeOrders < ActiveRecord::Migration
  def change
    add_column :spree_orders, :used_card_id, :integer
  end
end
