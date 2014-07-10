class Comment < ActiveRecord::Base

  # Description: Schema Description for Comment Class.

  #create_table "comments", force: true do |t|
  #  t.string   "commenter"
  #  t.string   "email"
  #  t.string   "website"
  #  t.text     "comment_body"
  #  t.boolean  "comment_notification"
  #  t.boolean  "post_notification"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #  t.integer  "post_id"
  #end

  belongs_to :post

	validates :commenter, presence: true, length: { minimum: 5 }
  validates :email, presence: true
  validates :comment_body, presence: true

end
