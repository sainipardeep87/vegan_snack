class CartItem < ActiveRecord::Base

  belongs_to :cart
  belongs_to :variant, class_name: "Spree::Variant"

=begin
  Description: will update the variant_id against cart_item and add quantity value to 1. As for selecting multiple
  cart_items of same type each will occupy single record/row in table. hence setting quantity to 1.
  Argument List: variant_id
  Return: cart_item object.
=end
  def prepare_cart_items(variant_id)
    self.update_attributes(variant_id: variant_id, quantity: 1)
  end

=begin
  Description: Below method will fetch the line_items of a specific cart.
  ArgumentList: cart_id
  Return: line_items.
=end
  def self.get_cart_items(cart_id)
    line_items = {}

    line_items[0] = CartItem.select('id, variant_id, order_id, quantity').where(cart_id: cart_id)
    line_items
  end

=begin
  Description: Below method will fetch the variants/products name from variant.
  Argument: cart_item object.
  Return: Variant name (string)
=end
 def get_cart_item_name
   Spree::Variant.where(id: self.variant_id).first.name
 end

=begin
  Description: On downgrading subscription, depending on lower subscription type extra subscribed snacks were removed
  from the CartItem.
  Argument: item_count, cart_id
  Return: nil
=end
  def self.drop_extra_items(item_count, cart_id)
    CartItem.where(cart_id: cart_id).limit(item_count).order("id desc").destroy_all
  end

end
