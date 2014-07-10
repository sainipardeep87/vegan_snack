class MyMailer < ActionMailer::Base
	# #super
  default from: '<no-reply@local.com>'

  def notify_user_after_cart_creation(user, delivery_date)

  	user_email = user.email

  	mail(:to => user_email, :subject => 'Order Details')

  end

  def notify_user_after_registration(user)
  	user_email = user.email
  	mail(:to => user_email, :subject => 'Welcome to Vegan snack packs')
  end

end