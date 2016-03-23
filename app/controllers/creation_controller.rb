class CreationController < ApplicationController
  before_action :getting_creations_params, only: :index

  def new
    new_creation = Creation.new
    current_user.creations << new_creation
    redirect_to creation_edit_url(new_creation)
  end

  def show
    @creation = Creation.get_creation params[:id]
    @chapters = Chapter.where(creation_id: @creation.id)
    @author = User.where(id: @creation.user_id).first
    @comments = Comment.where(creation_id: @creation.id)
    @new_comment = Comment.new
  end

  def edit
    @creation = Creation.where(id: params[:id]).first
    @chapters = Chapter.where(creation_id: @creation.id)
  end

  def update

  end

  def index
    @creations = Creation.get_some_creations params
    render :json => @creations.to_json
  end

  def read
    @chapter = Creation.where(id: params[:id]).first.chapters.first
  end

  private

  def getting_creations_params
    params.permit(:limit, :sort_by, :category)
  end

end
