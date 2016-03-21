class CreationController < ApplicationController

  def new
    current_user.creations << Creation.new
    redirect_to "/creation/#{current_user.creations.last.id}"
  end

  def show
    @creation = Creation.where(id: params[:id]).first
    @chapters = Chapter.where(creation_id: @creation.id)
    @author = User.where(id: @creation.user_id).first
    @comments = Comment.where(creation_id: @creation.id)
  end

  def edit

  end

  def read

  end

end
