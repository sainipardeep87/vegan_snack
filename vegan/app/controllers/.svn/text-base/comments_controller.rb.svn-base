class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
  	#@post = Post.find(params[:post_id])
    #raise params.inspect
    @post = Post.where(id: params[:post_id]).first

  	@comment = @post.comments.create(comment_params)
    #raise @comment.inspect

    if @comment.blank?
  	  respond_to do |format|
  		  format.js
      end
    end

  end

  private
  def set_comment
    @comment = Comment.where(id: params[:id]).first
    @comment = Comment.find_by_id(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :email, :website, :comment_body, :comment_notification, :post_notification, :post_id)
  end

end