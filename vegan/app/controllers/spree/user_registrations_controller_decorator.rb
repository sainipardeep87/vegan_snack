# Description: Overidding spree provided UserRegistrationController to customize as per my requirement
Spree::UserRegistrationsController.class_eval do

  #########################
  # Description: new action has been overridden over spree provided new action; mainly initialization of 
  # users address has been done in this Section.
  #########################
  def new
    
      super
      @user = resource
      @user.addresses.build
      
    end

    ############################
    # Description: create action of Spree has been overridden here and address attributes are being saved #in respective Model
    #############################
    def create
      
      @user = build_resource(spree_user_params)
      Spree::Address.new(address_params).save
    
      #raise Spree::PermittedAttributes.user_attributes.inspect
      #raise params.inspect
      #raise address_attributes.inspect
      #new_address = Spree::Address.create("firstname"=>"dlfalsf", "lastname"=>"alsfkasfd", "phone"=>"595959", "company"=>"mindfire", "address1"=>"midnfire", "address2"=>"midnfire", "city"=>"midnfire", "state_name"=>"State1", "zipcode"=>"955588")
      #raise new_address.inspect
      #Spree::Address.create(params.require(:address).permit(permitted_address_attributes))

      if resource.save
        set_flash_message(:notice, :signed_up)
        sign_in(:spree_user, @user)
        session[:spree_user_signup] = true
        associate_user
        sign_in_and_redirect(:spree_user, @user)
      else
        clean_up_passwords(resource)
        render :new
      end
    end

    ####################
    # Description: Adding parameters to permission list; so those will be allowed for create/update action
    ####################

    private
      def address_params
        #params.require(:address).permit(permitted_address_attributes)
        #params.require(["spree_user"]["address"]).permit(:address)
        #params.require(:address).permit(:address)
        params.require(:address).permit(:firstname, :lastname, :phone, :company, :address1, :address2, :city, :state_name, :zipcode)
      end
     
     #######################
     # Description: Adding user related attributes to permission list; hence allowed attributes can be accessed(created/updated).
     #######################
      def user_params

        params.require(:spree_user).permit(:email, :password, :password_confirmation, :address =>[:firstname, :lastname, :phone, :company, :address1, :address2, :city, :state_name, :zipcode])
      end

end