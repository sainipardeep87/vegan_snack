class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  #Description: Following action will initialize the new @comment
  def new
    @comment = Comment.new
  end

  #Description: Following action will create a comment below the relevant post
  def create
  	@post = Post.where(id: params[:post_id]).first
    @comment = @post.comments.create(comment_params)
  end

  private
  #Description: Following action wil set the @comment, for before_action mentioned actions.
  def set_comment
    #@comment = Comment.where(id: params[:id]).first
    @comment = Comment.find_by_id(params[:id])
  end

#Description: Following action will whitelist the comments params which will be updated.
  def comment_params
    params.require(:comment).permit(:commenter, :email, :website, :comment_body, :comment_notification, :post_notification, :post_id)
  end

end