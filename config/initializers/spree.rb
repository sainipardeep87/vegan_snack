# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # require "omniauth-facebook"
  # config.omniauth :facebook, "APP_ID", "APP_SECRET"
  config.site_name = "Spree Demo Site"
  config.override_actionmailer_config = false
  config.mails_from = "no-reply@local.com"
  config.enable_mail_delivery = true
  config.allow_ssl_in_production = false

  # Set default country to netherlands; will be set to NIL if not found.
  #config.default_country_id = Spree::Country.find_by_iso("NL").id

  #Spree::Config[:site_name] = 'localhost:3000'
  Spree::Config[:address_requires_state] = false


  if (Rails.env == 'production')

	  #Spree::Hub::Config[:hub_store_id] = "536b6f0869702d7acab30400"
	  #Spree::Hub::Config[:hub_token] = "690f16e1615b32ebd42f6797d365b33d39ee998699d99dc9"

    #below one is for staging and using same for local as well.
    Spree::Hub::Config[:hub_store_id] = "5397ef5f69702d4c491e0400"
    Spree::Hub::Config[:hub_token] = "16ec9a9ee787e1be95e4cd8e683f506c842abab48b5635ee"
  else
    Spree::Hub::Config[:hub_store_id] = "5397ef5f69702d4c491e0400"
    Spree::Hub::Config[:hub_token] = "16ec9a9ee787e1be95e4cd8e683f506c842abab48b5635ee"
	end

  Spree::Hub::Config[:hub_push_uri] = "https://my.wombat.co/push"
  Spree::Hub::Config[:enable_push] = true
  Spree::Config[:tax_using_ship_address] = false

  #To enable auto pushing of objects make sure the following configuration option is set
  #Spree::Hub::Config[:enable_auto_push] = true

end

Spree.user_class = "Spree::LegacyUser"
