Spree::UserSessionsController.class_eval do

  before_action :check_current_user_2, except: [:destroy, :create]
  layout 'application_login', only: [:new]

	#Description: Following action will initialize the user and build it's addresses.
  def new
    @user = Spree::User.new
    @user.addresses.build
    @hide_signin = true
    redirect_to root_path
  end

  # Description: Following action will perform login functionality & create Session.
  def create
		authenticate_spree_user!
		if current_user
			if current_user.has_spree_role?("admin")
        respond_to do |format|
          format.html{
            redirect_to '/spree/admin'
          }

          format.js{render js: %{location.reload();}}

        end
			else

				respond_to do |format|
          format.html{
            redirect_to '/'
          }

          format.js{
            # render js: %{location.reload();}
            render js:  %{window.location.href = '/spree/orders/snack_queue'}
          }

        end
			end
		else
			if request.referrer.split('/').last == 'admin'
				flash[:error] = "Invalid email or password"
				redirect_to '/admin'
			end
		end

  end

  # Description: Following Action will perform signout/session closing tasks.
   def destroy
      super
      after_sign_out_path_for(resource)
   end

  protected

	 def check_current_user_2
	   if current_user.present?
	     respond_to do |format|
	      format.html {redirect_to main_app.root_path}
	     end
	   end
	 end

end