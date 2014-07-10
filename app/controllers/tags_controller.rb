class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

#Description: Listing all the tags.
  def index
    @tags = Tag.all
  end

#Descripton: using show action display a single tag.
  def show
  end

#Descripton: intialize @tag for new Tag Creation.
  def new
    @tag = Tag.new
  end

#Descripton: edit action for editing tag.
  def edit
  end

#Description: Following action will  create & save a new tag to the list.
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
        redirect_to @tag, notice: 'Tag was successfully created.'
    else
        render 'new'
    end

  end
  
#Description: Following action will update/modfy the added tag.
  def update
  
      if @tag.update(tag_params)
        redirect_to @tag, notice: 'Tag was successfully updated.'
        
      else
        render 'edit'
      end
  end

#Description: Following action will remove/destory a tag from the Selection List.
  def destroy
    @tag.destroy
    redirect_to tags_url
  end

  private
# Description:  Using set_tag method for sharing the common functionality.
  def set_tag
    @tag = Tag.find(params[:id])
  end

# Descripton:  Allow attributes to be used for this particular controller
  def tag_params
    params.require(:tag).permit(:tagname)
  end

end