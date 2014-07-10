#############################################################
# Description: This override, will add a new button "Order Now", which in turn will create the "ORDER NOW" Div Section.
#############################################################
Deface::Override.new(
     :virtual_path => 'spree/user_sessions/new',
     :name => 'Get order Now button',
     :insert_before => 'div#existing-customer',
     :partial => 'overrides/Home/homepage_sidebar'
  )

#############################################################
# Description :This override will create a signup cum Billing Address Form.
#############################################################


  Deface::Override.new(
     :virtual_path => 'spree/user_registrations/new',
     :name => 'Registration page modification',
     :replace => "[data-hook='signup_inside_form']",
     :partial => 'overrides/Home/user_registration'
)


#############################################################
#Description: Removing New Customer label which is provided by Spree.
#############################################################
  
  Deface::Override.new(
     :virtual_path => 'spree/user_registrations/new',
     :name => "Remove New Customer Label",
     #:remove => "erb[loud]:contains('Spree.t(:new_customer)')",
     :replace => "erb[loud]:contains('Spree.t(:new_customer)')",
    :partial  => 'overrides/Home/user_registration'

  )
  
############################################################
# Description: This deface will be overriding spree provided default header with our custom header.
############################################################

  Deface::Override.new(
     :virtual_path => 'spree/shared/_header',
     :name => 'Replace the existing header',
    #:replace => "erb[loud]:contains('render :partial => #{'spree/shared/head'}')",
    #:replace => "erb[loud]:contains('spree/shared/nav_bar')",
      :replace => 'header.row',
     :partial => 'overrides/Home/header'
  )


############################################################
# Description : Just implementing a Variety Field to spree  provided default Billing Address Form.
############################################################
=begin
	Deface::Override.new(
		:virtual_path => 'spree/frontend/app/views/spree/address/_form',
		:name => 'just need to add a new variety field',
		#:insert_before => "p#bfirstname",
		#:insert_top => "div.inner",
		:remove => "[data-hook='billing_inner']"
	)

=end

#Description: Adding a new tab for blog section inside admin panel.

Deface::Override.new(
    :virtual_path => 'spree/layouts/admin',
    :name => 'custom-admin-tab',
    :replace => "nav#admin-menu",
    :text => '<h1>This is the new NAV</h1>'
)