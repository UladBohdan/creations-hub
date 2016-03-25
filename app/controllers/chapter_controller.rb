class ChapterController < ApplicationController

  def index
    @chapters = Chapter.all
    render :json => @chapters.to_json
  end

end
