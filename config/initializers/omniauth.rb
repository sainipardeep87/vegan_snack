OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.on_failure = Spree::UserRegistrationsController.action(:new)
end