class CreationController < ApplicationController

  def new
    new_creation = Creation.new
    current_user.creations << new_creation
    redirect_to creation_edit_url(new_creation)
  end

  def show
    @creation = Creation.where(id: params[:id]).first
    @chapters = Chapter.where(creation_id: @creation.id)
    @author = User.where(id: @creation.user_id).first
    @comments = Comment.where(creation_id: @creation.id)
    @new_comment = Comment.new
  end

  def edit
    @creation = Creation.where(id: params[:id]).first
    @chapters = Chapter.where(creation_id: @creation.id)
  end

  def read

  end

end
