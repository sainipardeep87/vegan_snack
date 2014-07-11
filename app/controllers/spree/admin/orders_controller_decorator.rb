Spree::Admin::OrdersController.class_eval do
  include Spree::Admin::OrdersHelper
  respond_to :html, :xml, :json, :js

  skip_before_action :verify_authenticity_token, only: :export

  before_action :set_search_params, only: [:range, :export]

  before_action :set_sort_params, only: [:index, :range]

  def index
=begin
    params[:q] ||= {}
    #params[:q][:completed_at_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
    #@show_only_completed = params[:q][:completed_at_not_null] == '1'
    params[:q][:s] ||= @show_only_completed ? 'completed_at desc' : 'created_at desc'

    # As date params are deleted if @show_only_completed, store
    # the original date so we can restore them into the params
    # after the search
    created_at_gt = params[:q][:created_at_gt]
    created_at_lt = params[:q][:created_at_lt]

    params[:q].delete(:inventory_units_shipment_id_null) if params[:q][:inventory_units_shipment_id_null] == "0"

    if !params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue ""
    end

    if !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    if @show_only_completed
      params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
      params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
    end
=end
    @search = Spree::Order.accessible_by(current_ability, :index).ransack(params[:q])

    # lazyoading other models here (via includes) may result in an invalid query
    # e.g. SELECT  DISTINCT DISTINCT "spree_orders".id, "spree_orders"."created_at" AS alias_0 FROM "spree_orders"
    # see https://github.com/spree/spree/pull/3919
    @orders = @search.result(distinct: true).page(params[:page]).per(params[:per_page] || Spree::Config[:orders_per_page])

    # Restore dates
=begin
    params[:q][:created_at_gt] = created_at_gt
    params[:q][:created_at_lt] = created_at_lt
    flash[:notice] = "Signed in Successfully" if flash[:notice].present?
=end

   respond_to do |format|
     format.html
     format.js
   end

  end

=begin
  Description: Action will filter the orders on basis of delivery date / ordered date depending on the date params
  selected in admin panel(From_to). in that range orders will be fetched and rendered in the page.
=end
  def range
    if valid_date_ranges?
      filtered_orders = Spree::Order.filter_on_delivery_date(@start_date, @end_date) if filter_on_delivery_date?
      filtered_orders = Spree::Order.filter_on_order_date(@start_date, @end_date) if filter_on_order_date?
    else
      filtered_orders = Spree::Order.get_all_orders
    end

    @orders = filtered_orders.page(params[:page]).per(params[:per_page] || Spree::Config[:orders_per_page])
    @search = Spree::Order.accessible_by(current_ability, :range).ransack(params[:q])

  end

=begin
  Description: Action will generate the excel sheet for the selected date range & if no date range is provided then the
    excel sheet will contain  all the orders details.
=end
  def export
    export_name ='Vegan_order_summary.xls'

    if valid_date_ranges?
      @orders = Spree::Order.export_on_delivery_date(@start_date, @end_date) if filter_on_delivery_date?
      @orders = Spree::Order.export_on_order_date(@start_date, @end_date) if filter_on_order_date?
      export_name = dynamic_file(@start_date, @end_date, @date_type)
    else
      @orders = Spree::Order.export_all_orders
    end

    respond_to do |format|
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{export_name}\"" if @orders.present? }
      format.js
    end

  end

  private

=begin
  Description: Following before_filter action, will set the @start_date, @end_date which are commonly used by the
  export & range actions.
=end
  def set_search_params
    min =  " 00:00:00 UTC"
    max = " 23:59:59 UTC"
    #those _params will be used to reset the dates again once the ranges are refreshed by the range.js.erb
    @start_date_params = params[:start_range]
    @end_date_params = params[:end_range]

    @start_date = Date.strptime(@start_date_params, "%m-%d-%Y").to_s + min  if @start_date_params.present?
    @end_date  = Date.strptime(@end_date_params, "%m-%d-%Y").to_s + max if @end_date_params.present?
    @date_type = params[:date][:types]

  end


  #Description: Following action will check the date ranges are valid or not.
  def valid_date_ranges?
    @start_date.present? && @end_date.present?
  end
  #Description: action will check the date_type is of Delivery Date or not.
  def filter_on_delivery_date?
    @date_type == "Delivery Date"
  end

  #Description: action will check the date_type is of Order Date or not.
  def filter_on_order_date?
    @date_type == "Order Date"
  end

  def set_sort_params
params[:q] ||= {}
    #params[:q][:completed_at_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
    #@show_only_completed = params[:q][:completed_at_not_null] == '1'
    params[:q][:s] ||= @show_only_completed ? 'completed_at desc' : 'created_at desc'

    # As date params are deleted if @show_only_completed, store
    # the original date so we can restore them into the params
    # after the search
    created_at_gt = params[:q][:created_at_gt]
    created_at_lt = params[:q][:created_at_lt]

    params[:q].delete(:inventory_units_shipment_id_null) if params[:q][:inventory_units_shipment_id_null] == "0"

    if !params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue ""
    end

    if !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    if @show_only_completed
      params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
      params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
    end

    # Restore dates

    params[:q][:created_at_gt] = created_at_gt
    params[:q][:created_at_lt] = created_at_lt
    flash[:notice] = "Signed in Successfully" if flash[:notice].present?

  end

end