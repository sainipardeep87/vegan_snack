class CreditcardsController < ApplicationController
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
    end

  end

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

  private
  #description: below action will white list the required parameters which will be used in above action.
  def creditcard_params
    params.require(:creditcard).permit(:cardholder_name, :card_no, :cvv, :month, :year)
  end

end