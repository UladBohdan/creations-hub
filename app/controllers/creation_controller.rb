class CreationController < ApplicationController
  #before_action :filter_params, only: :index
  before_action :set_creation, only: [:edit, :update, :destroy]

  def new
    new_creation = Creation.new
    current_user.creations << new_creation
    redirect_to edit_creation_url(new_creation)
  end

  def show
    @creation = Creation.get_creation params[:id]
    @chapters = Chapter.where(creation_id: @creation.id)
    @author = User.where(id: @creation.user_id).first
    @average_rating = Rating.get_average_rating params[:id]
    @your_rating = Rating.get_user_rating current_user.id, params[:id]
  end

  def edit
    @creation = Creation.get_creation params[:id]
    @chapters = Chapter.where(creation_id: @creation.id)
  end

  def update
    if @creation.update creation_params
      redirect_to creation_url(@creation), notice: "Creation was successfully updated!"
    else
      redirect_to creation_url(@creation), alert: "Creation wasn't updated as something went wrong."
    end
  end

  def destroy
    @creation.destroy
    redirect_to root_url
  end

  def index
    @creations = Creation.get_some_creations params
    respond_to do |format|
      format.js {}
    end
    #render :json => @creations.to_json
  end

  def read
    @chapter = Creation.where(id: params[:id]).first.chapters.first
  end

  private

  def filter_params
    params.permit(:limit, :sort_by, :category)
  end

  def set_creation
    @creation = Creation.where(id: params[:id]).first
  end

  def creation_params
    params.require(:creation).permit(:title, :category)
  end

end
