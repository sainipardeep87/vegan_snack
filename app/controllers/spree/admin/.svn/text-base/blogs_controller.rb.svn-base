class Spree::Admin::BlogsController < Spree::Admin::BaseController

  before_action :get_posts, :only => [:edit, :update, :destroy, :show]

  layout 'spree/layouts/admin'
  def index
    @blogs = Post.all
  end

  def new
    @post = Post.new
    @post.banner_images.build
    @post.tags.build #building multiple tags for a single Post.
  end

  def create  
    @post = Post.new(post_params)
    tag_attributes = params["post"]["tags"]["tagname"] # Separating tag related attributes from params list.

    if @post.save
      @post.save_new_tag_to_tag_table(tag_attributes) #this method will be saving tag_attributes to both tag & posts_tags tables explicitlity
      redirect_to "/spree/admin/blogs"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    render 'new'
  end

  def update
    if @post.update(post_params)
      tag_attributes = params["post"]["tags"]["tagname"]
      @post.tags.destroy_all
      @post.save_new_tag_to_tag_table(tag_attributes)
      redirect_to "/spree/admin/blogs", notice: 'Blog successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to  "/spree/admin/blogs", notice: 'Blog successfully deleted.' if @post.destroy
  end

  private

    def post_params
      params.require(:post).permit(:id, :title, :content, :post_image, :summary, banner_images_attributes: [:image, :_destroy, :id])
    end

    def get_posts
      @post = Post.where("id =?", params[:id]).first
      redirect_to "/spree/admin/blogs", notice: 'Blog Post was not found.' if @post.blank?
    end
end