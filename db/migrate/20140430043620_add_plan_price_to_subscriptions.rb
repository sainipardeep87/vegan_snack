class AddPlanPriceToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :plan_price, :decimal, :precision => 8, :scale => 2
  end
end
