class AddIsExpiredToCreditcards < ActiveRecord::Migration
  def change
    add_column :creditcards, :is_expired, :boolean, default: false
  end
end
