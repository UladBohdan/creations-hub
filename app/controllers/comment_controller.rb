class CommentController < ApplicationController
  before_action :set_comment, only: [:destroy, :like]

  def create
    if can? :create, Comment
      Comment.create! new_comment_params
    end
    render_comments
  end

  def destroy
    if can? :destroy, @comment
      @comment.destroy
    end
    render_comments
  end

  def like
    if can? :like, Comment
      user_like = nil
      @comment.likes.each { |like| user_like = like if like.user_id == current_user.id }
      if user_like.nil?
        @comment.likes.create! user_id: current_user.id
      else
        user_like.destroy
      end
    end
    render_comments
  end

  private

  def set_comment
    @comment = Comment.get_comment params[:id]
  end

  def new_comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, creation_id: params[:creation_id])
  end

  def render_comments
    @creation = Creation.get_creation_with_comments params[:creation_id]
    @comments = @creation.get_ordered_comments
    respond_to do |format|
      format.js { render "comments" }
    end
  end

end