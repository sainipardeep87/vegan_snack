Spree::Admin::OrdersController.class_eval do
  include Spree::Admin::OrdersHelper
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