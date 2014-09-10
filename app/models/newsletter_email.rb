class NewsletterEmail < ActiveRecord::Base
	self.table_name = "newsletter_email"

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :email,  presence: {message:  "An email address must be entered."},
      format:  { with:  email_regex , message:  "The email address is not valid." },
      length: {maximum: 50, message: "Maximum 50 characters allowed." }
      #uniqueness:  { case_sensitive: false, message: "Email ID already used."}

end