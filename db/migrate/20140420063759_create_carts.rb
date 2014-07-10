class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :subscription_id
      t.boolean :is_current, default: true
      t.datetime :delivery_date
    end
  end
end
