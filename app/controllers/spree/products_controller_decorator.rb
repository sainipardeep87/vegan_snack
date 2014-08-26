Spree::ProductsController.class_eval do

  layout 'application'
  before_action :authenticate_spree_user!
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
=begin
  Description: Listing all Snacks to our Users, on clicking any item those will be
  added to users Subscription List.
=end
  def index
    @searcher = build_searcher(params)
    @snacks = Spree::Product.select('id, name')
  end


  # Description: Following action will display our snack with bootstrap modal preview.
  def product_details

    #snack = Spree::Product.select('id,name, description, ingredients, nutritional_fact_image').where(id: params[:snack_id]).first
    snack = Spree::Product.where(id: params[:snack_id]).first
    snack_image = snack.images.first.attachment.url(:large)
    snack_nutritional_fact_image = snack.nutritional_fact_image.url(:original)

    if snack.present? && snack_image.present?
      render json: {
          snack_detail: snack,
          snack_image: snack_image,
          snack_nutritional_fact_image: snack_nutritional_fact_image
      }.to_json

    else
      rener json: {
          snack_detail: '',
          snack_image: ''
      }.to_json
    end

  end

  def list_products
    
  end

 end