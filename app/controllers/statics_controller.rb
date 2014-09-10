class StaticsController < ApplicationController
  skip_before_action :spree_current_user

#Description: initialize the @user variable for home action.
  def home
    @user = Spree::User.new
  end

# Description: New action signin, for the signin form. used temporarily to checkthe signin functionality.
  def signin
  end

# Descripton: Following action will combine all the static pages about_us, contact_us, snacks, home.
  def show
    page = params[:page]
    puts "the page is#{page}"
    render "statics#{page}"
  end

# Description: Following action is responsible for the snacks list details in home page snacks section.
  def snacks

    @snacks = Spree::Product.limit(5).order('id desc')
    @snacks.sort_by! { |x| x[:name].downcase }
  end

  def faq
  end

  def membership
    @subscriptions = Subscription.select('id, subscription_type', 'plan_price')
  end

  def snack_detail
    @snacks = Spree::Product.limit(6)
    @snacks.sort_by! { |x| x[:name].downcase }
  end

  def individual_product
    @snack = Spree::Product.find_by_id(params[:snack])
    @previous = Spree::Product.where("id < ?", params[:snack]).order(:id).last   
    @next = Spree::Product.where("id > ?", params[:snack]).order(:id).first 
  end

  def privacy_policy
    
  end

  def term_conditions
    
  end

end
