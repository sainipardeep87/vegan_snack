class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  helper_method :get_tag_details

# Description: Following action will list al the blog posts in the index Action.
  def index
    #@banners = BannerImage.includes(:post).order("created_at desc")
    #@first_banner = @banners.first
    #@banners = Post.includes(:banner_images).all


    @banners = BannerImage.joins(:post)
    @first_banner = @banners.first
    @banner_image = BannerImage.find_all_by_post_id(1,:conditions=>"image_file_name IS NOT NULL")

    @posts = Post.select('id, title, content')
    @slide_snacks = Post.get_post(5)
    @first_snack = @slide_snacks.first
    @feature_posts = Post.get_post(3)
    #@recent_posts = Post.get_post(4)
    @recent_posts = Post.all.paginate(page: params[:page], per_page: 4).order("created_at desc");
    @latest_posts = @feature_posts
   # @val = "This is how I approached the problem in the site I work for. When JavaScript is available, I truncate characters off the end until it fits with an ellipses at the end."
    #was using above text to check the content of blog on responsive pages.
  end


# Descripton: prepare the lateset posts in the show action section.
  def show
        @latest_posts = @post.get_latest_post(3)
  end

# Description: Following action will initialize the @post before creation.
  def new
    @post = Post.new
    @post.tags.build #building multiple tags for a single Post.
  end

#Description: Set the @post before any kind of edit/update.
  def edit
  end

#   Description: Creating post from post_params list. White listing tag list from complete params list and depending upon whether it's a new/existing tag,updating post_tags table.
  def create
    @post = Post.new(post_params)
    tag_attributes = params["post"]["tags"]["tagname"] # Separating tag related attributes from params list.

    if @post.save
        @post.save_new_tag_to_tag_table(tag_attributes) #this method will be saving tag_attributes to both tag & posts_tags tables explicitlity
        redirect_to @post, notice: 'Blog Post was successfully created.'
    else
        render 'new'
    end

  end

#Descripton: following action will update a blog post with the tag attributes as well.

  def update
    tag_attributes = params["post"]["tags"]["tagname"] # Separating tag related attributes from params list.
    @post.update_new_tag_to_tag_table(tag_attributes) #method will filter new tags and update them to tags table & posts_tags table.

    if @post.update(post_params)
       redirect_to @post, notice: "Post was Successfully Updated!"
    else
       render action: 'edit'
    end

  end

  #Description: Defined healper method, will remove the link from posts_tags table, when a tag is removed while editing.
  def destroy
    @post.destroy
    #Post.destroy_all  #For Now Destroy all posts for testing purpose; later on this block will be removed.
    redirect_to posts_url
  end

#Description: Tag on which we are chosing to be closed, will be removed from intermediate table posts_tags.
  def get_tag_details
    tag =Tag.where(:tagname => params[:tag_name]).pluck(:id)
    Post.remove_tagpost_link_from_posts_tag_table(tag[0]) unless tag.blank?
    render :nothing => true
  end

private

  # Using callbacks to share common setup or constraints between actions, rather than using the same block #of code in multiple places
  def set_post
    @post = Post.where(id: params[:id]).first
    redirect_to main_app.posts_path and return if @post.blank?
    render :file => 'public/404.html', :status => :not_found, :layout => false if @post.nil?
  end

  # Just allowing white listed attributes to get updated/created on a post
  def post_params
    #params.require(:post).permit(:id, :title, :content, :post_image_file_name, :post_image_content_type, :post_image_file_size, :post_image_updated_at, :post_image_file_name_file_name)
    params.require(:post).permit(:id, :title, :content, :post_image, :summary)
  end

end