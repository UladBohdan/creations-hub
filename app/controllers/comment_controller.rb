class CommentController < ApplicationController
  before_action :new_comment_params, only: [:create]
  before_action :before_removing_comment, only: [:destroy]

  def create
    if params[:add_comment] == "true"
      Comment.create creation_id: params[:creation_id], user_id: current_user.id, text: params[:text]
    end
    render_comments
  end

  def destroy
    if can? :destroy, @comment
      Comment.destroy @comment
    end
    render_comments
  end

  private

  def render_comments
    render :json => Comment.comments_for_creation(params[:creation_id]).to_json
  end

  def new_comment_params
    params.permit(:creation_id, :text, :add_comment)
  end

  def before_removing_comment
    params.permit(:id)
    @comment = Comment.where(id: params[:id])
  end

end