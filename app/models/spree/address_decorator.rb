Spree::Address.class_eval do
  before_validation :clear_validations_on_country
  #before_validation :clear_validations_on_phone
  belongs_to :user

  #phone_no_regex = /\A[0-9]{3}-[0-9]{3}-[0-9]{4}|[0-9]{10}|[(][0-9]{3}[)][0-9]{3}-[0-9]{4}\Z/
   phone_no_regex = /\A^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})\Z/

  #Adding new attribute Variety into address_attributes permission list.
  Spree::PermittedAttributes.address_attributes.push :variety

  validates :firstname, presence:{ message: "Firstname is required."},
            length: {maximum: 50, message: "Maximum 50 characters allowed." }

  validates  :lastname, presence: { message:  "Lastname is required." },
             length: {maximum: 50, message: "Maximum 50 characters allowed." }

  validates  :address1, presence: { message:  "Address  is required." },
             length: {maximum: 50, message: "Maximum 50 characters allowed." }

  validates  :city,  presence: { message:  "City is required." },
             length: {maximum: 50, message: "Maximum 50 characters allowed." }

  validates  :phone,  presence: { message:  "Phone no.  is required." },
             length: {maximum: 15, message: "Maximum 15 characters allowed." },
             format: {with: phone_no_regex, message: "Invalid phone no entered."}

  validates  :state_name,  presence: { message:  "State name is required." },
             length: {maximum: 50, message: "Maximum 50 characters allowed." }

  validates  :zipcode,  presence: { message:  "Zipcode is required." },
             length: {maximum: 50, message: "Maximum 50 characters allowed." }

  validates :company, length: {maximum: 50, message: "Maximum 50 characters allowed."}

  validates :address2, length: {maximum: 50, message: "Maximum 50 characters allowed."}



  #Description: Following action will remove the  validations added by Spree on country.
  def clear_validations_on_country
    _validators.reject!{ |key, value| key == :country }

    _validate_callbacks.each do |callback|
      callback.raw_filter.attributes.reject! { |key| key == :country } if callback.raw_filter.respond_to?(:attributes)
    end

  end


  #Description: Following action will remove the  validations added by Spree on phone.

def clear_validations_on_phone
  _validators.reject!{ |key, value| key == :phone }

  _validate_callbacks.each do |callback|
    callback.raw_filter.attributes.reject! { |key| key == :phone } if callback.raw_filter.respond_to?(:attributes)
  end

end


=begin
  Description: Following method will check entered Phone number is in proper format or not.
  Argument: phone no.
  Return : true/false (boolean result)
=end
  def self.is_phone_valid?(phone)
    phone_regex = /\A[0-9]{3}-[0-9]{3}-[0-9]{4}|[0-9]{10}|[(][0-9]{3}[)][0-9]{3}-[0-9]{4}\Z/
    result = phone =~ phone_regex
    result == 0 ? true : false
  end


=begin
    Descripton: following action will remove the default error messages added by Spree.
=end



  def remove_errormessages_added_by_spree

    self.errors.messages.each do |_,v|
      v.delete( "can't be blank" )
      v.delete("is invalid")
      v.delete("has already been taken")
      v.delete("Address is required.")
      #v.delete("Firstname is required.")
      #v.delete("Lastname is required.")
      #v.delete("phone no. is required.")
      #v.delete("State name is required.")
      #v.delete("zipcode is required.")
    end

  end
end