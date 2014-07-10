Spree::Admin::OrdersController.class_eval do
  include Spree::Admin::OrdersHelper

  skip_before_action :verify_authenticity_token, only: :export

  before_action :set_search_params, only: [:range, :export]

  def index
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

    @search = Spree::Order.accessible_by(current_ability, :index).ransack(params[:q])

    # lazyoading other models here (via includes) may result in an invalid query
    # e.g. SELECT  DISTINCT DISTINCT "spree_orders".id, "spree_orders"."created_at" AS alias_0 FROM "spree_orders"
    # see https://github.com/spree/spree/pull/3919
    @orders = @search.result(distinct: true).
      page(params[:page]).
        per(params[:per_page] || Spree::Config[:orders_per_page])

    # Restore dates
    params[:q][:created_at_gt] = created_at_gt
    params[:q][:created_at_lt] = created_at_lt
    flash[:notice] = "Signed in Successfully" if flash[:notice].present?
  end

  def range

    if valid_date_ranges?
      filtered_orders = Spree::Order.filter_on_delivery_date(@start_date, @end_date) if filter_on_delivery_date?
      filtered_orders = Spree::Order.filter_on_order_date(@start_date, @end_date) if filter_on_order_date?
    else
      filtered_orders = Spree::Order.get_all_orders
    end

    logger.info "orders in the selected range are #{filtered_orders.count}"

    @orders = filtered_orders.page(params[:page]).per(params[:per_page] || Spree::Config[:orders_per_page])
    @search = Spree::Order.accessible_by(current_ability, :range).ransack(params[:q])

  end


  def export
    export_name ='Vegan_order_summary.xls'

    if valid_date_ranges?
      @orders = Spree::Order.export_on_delivery_date(@start_date, @end_date) if filter_on_delivery_date?
      @orders = Spree::Order.export_on_order_date(@start_date, @end_date) if filter_on_order_date?
    else
      @orders = Spree::Order.export_all_orders
    end

    respond_to do |format|

      format.xls {
        logger.info "*****************************************"
        #text/html,application/xhtml+xml,application/xml;
        headers["Content-Disposition"] = "attachment; filename=\"#{export_name}\""

       }
    end

  end

  private

  def set_search_params
    @start_date = Date.parse(params[:start_range]) if params[:start_range].present?
    @end_date = Date.parse(params[:end_range]) if params[:end_range].present?
    @date_type = params[:date][:types]
  end

  def valid_date_ranges?
    @start_date.present? && @end_date.present?
  end

  def filter_on_delivery_date?
    @date_type == "delivery date"
  end

  def filter_on_order_date?
    @date_type == "order date"

    start_date = Date.parse(params[:start_range])
    end_date = Date.parse(params[:end_range])

    if start_date.present? && end_date.present?
      @orders = Spree::Order.where('delivery_date >  ? && delivery_date < ?',start_date , end_date).page(params[:page]).
        per(params[:per_page] || Spree::Config[:orders_per_page])
        @search = Spree::Order.accessible_by(current_ability, :index).ransack(params[:q])

      #render 'index'
    end

  end

  def export
    @orders = Spree::Order.order(:created_at)
    export_name ='Vegan_order_summary.xls'
     respond_to do |format|
      #format.xls { filename: 'VeganSnacks_Order_summary.xls'}
      format.xls {headers["Content-Disposition"] = "attachment; filename=\"#{export_name}\""}
      end

  end

end