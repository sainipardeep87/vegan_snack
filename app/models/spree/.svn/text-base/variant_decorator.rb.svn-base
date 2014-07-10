Spree::Variant.class_eval do

    has_many :cart_items, class_name: "CartItem"
    belongs_to :product, :class_name => 'Spree::Product', :foreign_key => 'product_id'
end
