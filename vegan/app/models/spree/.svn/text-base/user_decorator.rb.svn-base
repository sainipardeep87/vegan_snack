Spree::User.class_eval do
  #before_validation :strip_all_inputs
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #Server side validation for each of the input fields.

  validates :email, :presence =>{:message => "An email address must be entered."},
            :format => { :with => email_regex , :message => "The email address is not valid." },
            :uniqueness => { :case_sensitive => false,  :message => "The email address is already in use."}


   #Add new Attributes to user_attributes permission list.

   #Spree::PermittedAttributes.user_attributes.push :addresses_attributes => [:firstname, :lastname, :address1, :address2, :city, :zipcode, :phone, :statename, :company]
   Spree::PermittedAttributes.user_attributes.push :ship_to_same_address

   has_many :addresses #, class_name: 'Spree::Address'

   accepts_nested_attributes_for :addresses  #to Support nested attributes with User Details.

   ########################################################################################  
   # Description: Strip/Remove unwanted space characters(if supplied by user input field), so that those attributes
   #              can be saved in Database in proper format. 
   # Argument   : NIL
   # Return     : NIL
   ########################################################################################

  def strip_all_inputs

     self.email =self.email.strip if self.email.class == String
     self.first_name = self.first_name.strip if self.first_name.class == String
     self.last_name = self.last_name.strip if self.last_name.class == String
     self.telephone  = self.telephone.strip if self.telephone.class == String
     self.company_name = self.company_name.strip if self.company_name.class == String
     self.address_line_1 = self.address_line_1.strip if self.address_line_1.class == String
     self.address_line_2 = self.address_line_2.strip if self.address_line_2.class == String
     self.city = self.city.strip if self.city.class == String
     self.zipcode = self.zipcode.strip if self.zipcode.class == String


  end

end