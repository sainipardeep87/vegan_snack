class AddUserIdToSpreeLineItems < ActiveRecord::Migration
  def change
    add_column :spree_line_items, :user_id, :integer
  end
end
