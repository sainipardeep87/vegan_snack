Spree::UserPasswordsController.class_eval do
include ApplicationHelper

	layout 'application'

	after_action :redirect_user_path, only: [:update]

	def new
		super
		@hide_signin = true
	end

	def create
		@hide_signin = true
		@user = Spree::User.where(:email => params[:spree_user][:email]).first
		if @user.blank?
			@flag = true
		else
			 u = Spree::User.where(params[resource_name]).first
			 raw, enc = Devise.token_generator.generate(u.class, :reset_password_token)

			 #@user.reset_password_token = enc
			 #@user.save
       @user.update_attributes(reset_password_token: enc, reset_password_sent_at: Time.now)

			 email_url = Vegan::Application.config.forgot_password_url + raw
			 parameters = get_forgot_password_params(email_url, @user)
			 VeganMailer.forgotpassword_email(parameters).deliver

	    if @user.present?
	      set_flash_message(:notice, :send_instructions) if is_navigational_format?
	      #respond_with resource, :location => spree.login_path
	    else
	    	@flag = true
	      #respond_with_navigational(resource) { render :new }
	    end
			@flag = false
		end
	end

	def edit
		super
		@hide_signin = true
	end

	def update
		@hide_signin = true
		if params[:spree_user][:password] == params[:spree_user][:password_confirmation]
			super
		else
			render 'edit'
		end
	end

	protected

	def check_current_user_2
		if current_user.present?
			respond_to do |format|
				format.html {redirect_to main_app.root_path}
			end
		end
	end

	def redirect_user_path

	end

end