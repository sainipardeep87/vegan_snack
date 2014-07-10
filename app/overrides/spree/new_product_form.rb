Deface::Override.new(:virtual_path => 'spree/admin/products/new',
                     :replace_contents => "[data-hook='new_product']",
                     :partial => '/overrides/products/shared/form',
                     :name => 'product_new')

Deface::Override.new(:virtual_path => 'spree/admin/products/_form',
                      :replace => "[data-hook='admin_product_form_fields']",
                      :partial => '/overrides/products/shared/form',
                      :name => 'product_edit')

Deface::Override.new(:virtual_path => 'spree/admin/shared/_product_tabs',
                     :replace_contents => "[data-hook='admin_product_tabs']",
                     :partial => '/overrides/products/shared/product_side_nav',
                     :name => 'product_side_nav')

Deface::Override.new(:virtual_path => 'spree/admin/shared/_product_sub_menu',
                     :remove => "[data-hook='admin_product_sub_tabs']",
                     :name => 'remove_admin_product_sub_tab')

Deface::Override.new(:virtual_path => 'spree/admin/products/index',
                     :replace_contents => "[data-hook='admin_products_index_search']",
                     :partial => '/overrides/products/shared/product_search',
                     :name => 'modify_product_search')

Deface::Override.new(:virtual_path => 'spree/admin/products/index',
                     :replace_contents => "table#listing_products",
                     :partial => '/overrides/products/shared/list',
                     :name => 'listing_products')