class AddUserRegistrationDetailsToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :first_name, :string
    add_column :spree_users, :last_name, :string
    add_column :spree_users, :telephone, :string
    add_column :spree_users, :company_name, :string
    add_column :spree_users, :address_line_1, :string
    add_column :spree_users, :address_line_2, :string
    add_column :spree_users, :city, :string
    add_column :spree_users, :state, :string
    add_column :spree_users, :zipcode, :string
    add_column :spree_users, :ship_to_same_address, :boolean
  end
  
end
