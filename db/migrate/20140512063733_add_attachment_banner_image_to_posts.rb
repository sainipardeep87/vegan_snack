class AddAttachmentBannerImageToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :banner_image
    end
  end

  def self.down
    drop_attached_file :posts, :banner_image
  end
end
