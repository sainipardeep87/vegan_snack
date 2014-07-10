class Vendor < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, :presence => true
  validates :email, :presence => true, :format => {:with => email_regex, :message => "is not valid"} ,
            :uniqueness => {:case_sensitive => false}

  has_many :products, class_name: 'Spree::Product', foreign_key: 'vendor_id'

  def deleted?
    deleted
  end
end
