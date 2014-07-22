class Spree::Admin::CouponsController <  Spree::Admin::BaseController
  layout 'spree/layouts/admin'

  skip_before_action :authorize_admin, only: :check_valid_coupon

  before_action :get_coupon, only: [:edit, :update, :destroy]
  before_action :get_discounts, except: [:check_valid_coupon, :destroy, :generate_coupon]
  before_action :clear_braintree_removed_discount_ids, only: :index

  include CouponsHelper

 	#below action will check entered coupon is valid or not.
 	def check_valid_coupon
 		code = params[:spree_user][:coupon_code]
 		is_valid_coupon = Coupon.is_valid?(code.strip) if code.present?
    render json: is_valid_coupon.present? #true/false
 	end

  #action will list all the undeleted coupons in admin section.
 	def index
 		@coupons = Coupon.all.where(deleted: false)
    @search = Coupon.new
    @code = Coupon.generate_unique_code
	end

  # action will initialize the @coupon object.
	def new
		@coupon = Coupon.new
	end

  # action will create coupon on successful save else render the new action
	def create
		@coupon = Coupon.new(coupon_params)
    @coupon.set_discount_ID
    @coupon.validate_couponcode = true

    	if @coupon.save
        flash[:success] = Spree.t('Coupon has been successfully created.')
      	redirect_to '/spree/admin/coupons'
    	else
        render 'new'
    	end
	end

  # action will render the edit form for coupon update.
	def edit
    	render 'new'
  end

#if valid coupon details entered then new coupon will be added and the existing coupon will be marked as deleted.
  def update
    new_coupon = Coupon.new(coupon_params)
    new_coupon.set_discount_ID
    new_coupon.validate_couponcode = true unless new_coupon.coupon_code.strip == @coupon.coupon_code
    if new_coupon.valid?
      if is_changed_coupon?(@coupon, new_coupon)
        @coupon.update_column(:deleted, true)
        new_coupon.save
      else
        @coupon.update_attributes(updated_at: Time.now)
      end
      flash[:success] = Spree.t('Coupon has been successfully updated.')
      redirect_to '/spree/admin/coupons'
    else

      #@coupon = new_coupon
      @coupon.assign_attributes(coupon_params)
      @coupon.set_discount_ID
      @coupon.save
      #@coupon.update_attributes(coupon_params)
      render 'new'
    end

  end

  #below action will mark a coupon object deleted.
	def destroy
    @coupon.update_column(:deleted, true)
  	flash[:success] = Spree.t('Coupon has been successfully deleted.')
  	redirect_to '/spree/admin/coupons'
	end

  #below action will generate unique coupon code in VEG445NMB format.
  def generate_coupon
    @code = Coupon.generate_unique_code

    respond_to do |format|
      format.js
    end

  end

  protected
  #function will whitelist required parameters for further operation.
  def coupon_params
    params.require(:coupon).permit!
  end

  #its an action to set the @coupon object before edit, :update, :destroy are initiated.
  def get_coupon
    @coupon = Coupon.where(id: params[:id]).first
    redirect_to '/spree/admin/coupons' if @coupon.blank?
  end

  #following action will fetch all the discounts added over braintree in following format
  #{0=>"10_dollar_off", 1=>"vegan_large_discount", 2=>"vegan_medium_discount"}
  def get_discounts
    @discounts = Coupon.fetch_braintree_discounts
  end

  # below method will check the discount ids deleted at braintree site & those will be marked deleted
  #in local also.
  def clear_braintree_removed_discount_ids
    bt_discounts = Coupon.fetch_braintree_discounts
    Coupon.clear_braintree_removed_discounts_from_local(bt_discounts.keys)
  end

end