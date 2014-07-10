class AddAttachmentNutritionalFactImageToSpreeProducts < ActiveRecord::Migration
  def self.up
    change_table :spree_products do |t|
      t.attachment :nutritional_fact_image
    end
  end

  def self.down
    drop_attached_file :spree_products, :nutritional_fact_image
  end
end
