class RenameColumnAmountToDiscountRateCoupons < ActiveRecord::Migration

	def self.up
		rename_column :coupons, :amount, :discount_rate
  	end

  	def self.down
    	rename_column :coupons, :discount_rate, :amount
  	end
  	
end
