class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.string :discount_name
      t.string :braintree_discount_id
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :counter, default: 0

      t.timestamps
    end
  end
end
