Spree::Address.class_eval do

	belongs_to :user #, class_name: 'Spree::User'
	
	#Adding new attribute Variety into address_attributes permission list. 
 	Spree::PermittedAttributes.address_attributes.push :variety

  #validates_presence_of :firstname, :lastname, :address1, :phone

  #validates :firstname, :presence =>{:message => "is Missing."}
  validates_presence_of :firstname
end