# Description: Added PostsController to control blog post Creation Functionality

class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  helper_method :get_tag_details

  def index
    @posts =Post.select('id, title, content')
    #@posts = Post.pluck(:id, :title, :content)
  end

  def show
    @latest_posts = @post.get_latest_post(1)
  end

  def new
    @post = Post.new
    #raise @post.inspect
    @post.tags.build #building multiple tags for a single Post. 
  end

  def edit
  end

=begin
   Description: Creating post from post_params list.
  White listing tag list from complete params list and depending upon whether it's a new/existing tag,updating post_tags table.
=end
  def create

    #raise params.inspect
    @post = Post.new(post_params)
    tag_attributes = params["post"]["tags"]["tagname"] # Separating tag related attributes from params list.

    #raise @post.inspect

    if @post.save
        @post.save_new_tag_to_tag_table(tag_attributes) #this method will be saving tag_attributes to both tag & posts_tags tables explicitlity
        redirect_to @post, notice: 'Blog Post was successfully created.'
    else
        render 'new'
    end

  end

  def update
    tag_attributes = params["post"]["tags"]["tagname"] # Separating tag related attributes from params list.
    @post.update_new_tag_to_tag_table(tag_attributes) #method will filter new tags and update them to tags table & posts_tags table.

    if @post.update(post_params)
       redirect_to @post, notice: "Post was Successfully Updated!"
    else
       render action: 'edit'
    end

  end

=begin
  #Description: Defined healper method, will remove the link from posts_tags table, when a tag is removed while editing.
=end


  def destroy
    @post.destroy
    #Post.destroy_all  #For Now Destroy all posts for testing purpose; later on this block will be removed.
    redirect_to posts_url
  end


=begin
Description: Tag on which we are chosing to be closed, will be removed from intermediate table posts_tags.
=end
  def get_tag_details
    tag =Tag.where(:tagname => params[:tag_name]).pluck(:id)
    Post.remove_tagpost_link_from_posts_tag_table(tag[0]) unless tag.blank?
    render :nothing => true
  end

  def home

  end


private

  # Using callbacks to share common setup or constraints between actions, rather than using the same block #of code in multiple places
  def set_post
    @post = Post.find(params[:id])
    #@post = Post.select('id, title, content, post_image_file_name, post_image_content_type, post_image_file_size, post_image_updated_at').where(id: params[:id]).first
    render :file => 'public/404.html', :status => :not_found, :layout => false if @post.nil?
  end

  # Just allowing white listed attributes to get updated/created on a post
  def post_params
    #params.require(:post).permit(:id, :title, :content, :post_image_file_name, :post_image_content_type, :post_image_file_size, :post_image_updated_at, :post_image_file_name_file_name)
    params.require(:post).permit(:title, :content, :post_image)
  end


end