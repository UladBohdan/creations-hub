class CreationController < ApplicationController
  before_action :set_creation, only: [:update, :destroy, :rate, :show]
  before_action :set_creation_to_edit, only: :edit

  def new
    new_creation = Creation.new
    current_user.creations << new_creation
    redirect_to edit_creation_url(new_creation)
  end

  def show
    @comments = @creation.get_ordered_comments
    set_ratings
  end

  def edit
    @chapters = @creation.chapters
  end

  def update
    if @creation.update! creation_params
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
    @creations = Creation.get_set_of_creations filter_params
    respond_to do |format|
      format.js {}
    end
  end

  def rate
    if can? :rate, Creation
      if @creation.ratings.where(user_id: current_user.id).empty?
        @creation.ratings.create value: params[:new_value], user_id: current_user.id
      else
        @creation.ratings.where(user_id: current_user.id).first.update value: params[:new_value]
      end
    end
    set_ratings
    respond_to do |format|
      format.js {}
    end
  end

  private

  def filter_params
    params.permit(:limit, :sort, :category)
  end

  def set_creation
    @creation = Creation.get_creation params[:id]
  end

  def set_creation_to_edit
    @creation = Creation.get_creation_to_edit params[:id]
  end

  def set_ratings
    @average_rating = Rating.get_average_rating @creation
    @your_rating = 0
    if user_signed_in?
      @your_rating = Rating.get_user_rating current_user.id, @creation
    end
  end

  def creation_params
    params[:creation][:category] = nil if params[:creation][:category] == 0
    params.require(:creation).permit(:title, :category, { tag_list: [] })
  end

end
