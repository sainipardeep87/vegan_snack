module CustomerDetailsHelper

=begin
    Description: Method will fetch the error message specific to field and return it to the customer details view.
    Argument List: Address_type, field_name, errors
    Return: error message.
=end
    def customer_details_error(address_type, field_name, errors)
        #@order.errors.messages[:"ship_address.lastname"][0]
        key = (address_type + "." + field_name).to_sym
        errors[key][0] if errors[key].present?
    end

end