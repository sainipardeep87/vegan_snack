class AddAttachmentImageToBannerImages < ActiveRecord::Migration
  def self.up
    change_table :banner_images do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :banner_images, :image
  end
end
