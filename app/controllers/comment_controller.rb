class CommentController < ApplicationController
  before_action :set_creation

  def create
    @creation.comments.new(comment_params)
    redirect_to creation_url
  end

  private

  def set_creation
    @creation = Creation.where(id: params[:creation_id]).first
  end

  def comment_params
    params.require(:comment).permit(:text, :creation_id, :user_id)
  end

end