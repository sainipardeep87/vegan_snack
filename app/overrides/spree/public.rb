Deface::Override.new(:virtual_path => 'spree/admin/shared/_header',
                     :replace_contents => "[data-hook='logo-wrapper']",
                     :partial => '/overrides/admin/shared/logo',
                     :name => 'change_logo')

Deface::Override.new(:virtual_path => 'spree/admin/shared/_header',
                     :replace_contents => "[data-hook='store-frontend-link']",
                     :partial => '/overrides/admin/shared/blog_link',
                     :name => 'add_blog_link')