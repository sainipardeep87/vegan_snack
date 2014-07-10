class Tag < ActiveRecord::Base

  # Description: Schema Description for Tag Class
  # create_table "tags", force: true do |t|
  #   t.string   "tagname"
  #   t.datetime "created_at"
  #   t.datetime "updated_at"
  # end

  has_and_belongs_to_many :posts

end
