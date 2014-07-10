Spree::Admin::ProductsController.class_eval do
  before_filter :get_vendor, only: [:new, :create, :edit, :update, :clone]
  before_filter :set_vendors_in_product_includes


  protected

  def get_vendor
    #@taxons = Taxon.order(:name)
    #@option_types = OptionType.order(:name)
    #@tax_categories = TaxCategory.order(:name)
    #@shipping_categories = ShippingCategory.order(:name)
    @vendors = Vendor.where(deleted: false).order(:name)
  end

  def set_vendors_in_product_includes
    product_includes.first.merge!({:vendor => []})
  end


  def permit_attributes
    params.require(:product).permit!
  end

  def product_params_list
    params.require(:product).permit!
  end
end