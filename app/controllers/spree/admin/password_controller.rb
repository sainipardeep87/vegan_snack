class Spree::Admin::PasswordController < Spree::Admin::BaseController
  layout 'spree/layouts/admin'

  def new

  end

  def create
    @user = current_user
    @valid_login = Spree::User.check_valid_user?(@user.email, params[:user][:current_password]) #unless @user.blank?

    if @valid_login
      @user.updating_password = true
      if @user.update_attributes(user_params_list)
        sign_in @user, :bypass => true
        redirect_to "/spree/admin/", notice: "Password updated successfully"
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  private
  #Description: sets whitelisted user_params_list.
  def user_params_list
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :updating_password,  addresses_attributes: [:id, :firstname, :lastname, :phone, :company, :address1, :address2, :city, :state_name, :zipcode, :country])
  end

end