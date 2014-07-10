class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.string :email
      t.string :website
      t.text :comment_body
      t.boolean :comment_notification
      t.boolean :post_notification

      t.timestamps
    end
  end
end
