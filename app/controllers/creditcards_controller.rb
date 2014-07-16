class CreditcardsController < ApplicationController

  before_action :authenticate_spree_user!

  include CreditcardsHelper
  respond_to :html, :xml, :js, :json

  def confirm_payment
    @cart = current_cart
  end
=begin
  Description: Below method will add credit card details over braintree and save the returned parameter in DB.
  once payment is done then only saving the address details permanently  by setting the is_complete flag to "true"
=end

  def add_card_complete_payment
    @billing_id = params[:billing_address_id]
    @shipping_id = params[:shipping_id]
    billing_address = Spree::Address.where(:id => @billing_id).first
    shipping_address = Spree::Address.where(:id => @shipping_id).first
    user = current_user

    @card = Creditcard.new(creditcard_params)
    if @card.valid? #checking @card validation before pushing it over braintree for validation.
      result = Creditcard.create_only_creditcard_over_braintree(user.braintree_customer_id, @card)
      @braintree_cc_return = result.success? ? result.credit_card : nil

      if @braintree_cc_return.present?
        @card.save
        @card.update_attributes(:user_id => user.id)
        @card = Creditcard.update_creditcard(@braintree_cc_return, user.id)
        billing_address.update_attributes(is_complete: true)
        shipping_address.update_attributes(is_complete: true)
      end
    else
      logger.info @card.errors.messages
    end

  end
=begin
  Description: Action will perform payment during subscription resume functionality. On collected creditcard details the card will
  be added to users creditcard list.
=end
  def pay
    @card = Creditcard.new(creditcard_params)

    user = current_user

    if @card.valid?
      result = Creditcard.create_only_creditcard_over_braintree(user.braintree_customer_id, @card)
      @braintree_cc_return = result.success? ? result.credit_card : nil
    end


    if @braintree_cc_return.present?
      @card.save
      @card.update_attributes(user_id: user.id)
      @card = Creditcard.update_creditcard(@braintree_cc_return, user.id)
    end

  end

=begin
  Description: Action will update the creditcard if the user wishes to change the creditcard info associated with a subscription/order.
  this action is also responsible for updating creditcard in case the subscription has been blocked because of invalid creditcard(mostly
  the card has expired). In both scenarios this action will be used with a extra param to recognize for which feature this action is being called.
  During normal update an extra param(update= true) will be sent where as during an expired creditcard no such params will be received.
  depending on this further redirection/flow will be decided.
=end
  def update
    #@card = Creditcard.new(creditcard_params)
    @is_update =params[:update] #this flag will be used to track it's for unblocking card or for simple Card Update.
    @card = Creditcard.where(id: params[:id]).first
    user = current_user

    if @card.present?
      @card.assign_attributes(creditcard_params)
        if @card.valid?
          result = Creditcard.update_creditcard_at_braintree(@card)
          @braintree_cc_return = result.success? ? result.credit_card : nil
        end
        #@card = Creditcard.update_creditcard(@braintree_cc_return, user.id) if @braintree_cc_return.present?
        @card.replace_old_card(@braintree_cc_return) if @braintree_cc_return.present?
    end
  end

  private
  #description: below action will white list the required parameters which will be used in above action.
  def creditcard_params
    params.require(:creditcard).permit(:cardholder_name, :card_no, :cvv, :month, :year)
  end

end