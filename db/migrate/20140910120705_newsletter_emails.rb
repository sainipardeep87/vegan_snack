class NewsletterEmails < ActiveRecord::Migration
  
  	 def change
    	create_table :newsletter_email do |t|
      		t.string :email
    	end
  end
  
end
