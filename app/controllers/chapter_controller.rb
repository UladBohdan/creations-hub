class ChapterController < ApplicationController
  before_action :set_creation

  def index
    @chapters = @creation.chapters.all
    render :json => @chapters.to_json
  end

  def update
    Chapter.where(id: params[:id]).first.update(text: params[:text], title: params[:title])
    @chapters = @creation.chapters.all
    render :json => @chapters.to_json
  end

  private

  def update_chapter_params
    params.require(:chapter).permit(:text, :title)
  end

  def set_creation
    @creation = Creation.get_creation params[:creation_id]
  end

end
