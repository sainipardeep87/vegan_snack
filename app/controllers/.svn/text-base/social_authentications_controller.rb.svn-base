class SocialAuthenticationsController < ApplicationController


=begin
Description: following action will populate the form for completing signup process.
Argument List : NIL
Return: NIL
=end

  def complete_signup
    fetch_facebook_params
    @user = Spree::User.select(:id, :facebook_token, :email, :login).where(email: session[:email]).first

    if @user.blank?
      @user = Spree::User.new(email: session[:email])
      @user.addresses.build
    else
      @user.update_attributes(facebook_token: session[:fb_token]) if @user.facebook_token != session[:fb_token] #update the token if @user_founds token is not same as the @fb_token
      signin_vegan_user(@user.id)
    end

  end

=begin
Description: following action will create new User and complete the signup process.
Argument LIst: NIL
Return: NIL
=end

  def signup_facebook_user
    @user = Spree::User.new(user_params_list)
    @user.facebook_token = session[:fb_token]

    @user.addresses.first.country_id = 503

    if @user.save
      session
      signin_vegan_user(@user.id)
      else
        render 'complete_signup'
      end
  end

=begin
 Description: following action will extract required parameters from long facebook params list and will be used in signup form
Argument LIST: NIL
Return: filtered params list(email, firstname, lastname)
=end
  def fetch_facebook_params

    @fb_details = request.env['omniauth.auth']
    redirect_to main_app.root_path if @fb_details.nil?

    session[:email] =  @fb_details[:info][:email]
    session[:firstname] =  @fb_details[:info][:first_name]
    session[:lastname] = @fb_details[:info][:last_name]
    session[:fb_token] =  @fb_details[:credentials][:token]

  end

# Description: Adding parameters to permission list; so those will be allowed for create/update action
  private
  def user_params_list
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :updating_password, :facebook_token, addresses_attributes: [:id, :firstname, :lastname, :phone, :company, :address1, :address2, :city, :state_name, :zipcode, :country])
  end

end