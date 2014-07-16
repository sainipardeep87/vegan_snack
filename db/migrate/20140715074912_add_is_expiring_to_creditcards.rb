class AddIsExpiringToCreditcards < ActiveRecord::Migration
  def change
    add_column :creditcards, :is_expiring, :boolean, default: false
  end
end
