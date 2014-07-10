class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :quantity
      t.string :subscription_type
      t.string :plan_id
    end
  end
end
