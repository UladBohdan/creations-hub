class CommentController < ApplicationController
  before_action :set_creation
  before_action :set_comment, only: [:destroy, :like]
  before_action :set_all_comments

  def create
    if can? :create, Comment
      @creation.comments.create(user_id: current_user.id, text: new_comment_params[:text])
    end
    respond_to do |format|
      format.js { render "comments" }
    end
  end

  def destroy
    if can? :destroy, @comment
      @comment.destroy
    end
    respond_to do |format|
      format.js { render "comments" }
    end
  end

  def like
    if can? :like, Comment
      if @comment.likes.where(user_id: current_user.id).empty?
        @comment.likes.create user_id: current_user.id
      else
        @comment.likes.where(user_id: current_user.id).first.destroy
      end
    end
    render_comments
  end

  private

  def set_creation
    @creation = Creation.get_creation params[:creation_id]
  end

  def set_comment
    @comment = @creation.comments.where(id: params[:id]).first
  end
  
  def set_all_comments
    @comments = @creation.get_ordered_comments
  end

  def new_comment_params
    params.require(:comment).permit(:creation_id, :text)
  end

  def render_comments
    respond_to do |format|
      format.js { render "comments" }
    end
  end

end