class Spree::Admin::VendorsController < Spree::Admin::BaseController
  layout 'spree/layouts/admin'
  before_filter :get_vendor, only: [:edit, :update, :destroy]
  def index
    @vendors = Vendor.where(deleted: false)
    @search = Vendor.new
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      flash[:success] = Spree.t('Vendor has been successfully created.')
      redirect_to '/spree/admin/vendors'
    else
      render 'new'
    end
  end

  def edit
    render 'new'
  end

  def update
    if @vendor.update_attributes(vendor_params)
      flash[:success] = Spree.t('Vendor has been successfully updated.')
      redirect_to '/spree/admin/vendors'
    else
      render 'new'
    end
  end

  def destroy
    @vendor.update_column(:deleted, true)
    flash[:success] = Spree.t('Vendor has been successfully deleted.')
    redirect_to '/spree/admin/vendors'
  end

  protected

  def vendor_params
    params.require(:vendor).permit!
  end

  def get_vendor
    @vendor = Vendor.where(id: params[:id], deleted: false).first
    redirect_to '/spree/admin/vendors' if @vendor.blank?
  end
end