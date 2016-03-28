class ChapterController < ApplicationController
  before_action :set_creation, except: :read
  before_action :set_chapters, except: [:create, :read]
  before_action :set_chapter, only: :read

  def create
    @creation.chapters << Chapter.create!(title: "Title for your new chapter!", text: "**Your new chapter text**")
    set_chapters
    render :json => @chapters.to_json
  end

  def index
    render :json => @chapters.to_json
  end

  def update
    Chapter.where(id: params[:id]).first.update(text: params[:text], title: params[:title])
    render :json => @chapters.to_json
  end

  def read
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @markdowned = markdown.render(@chapter.text)
  end

  private

  def update_chapter_params
    params.require(:chapter).permit(:text, :title)
  end

  def set_creation
    @creation = Creation.get_creation params[:creation_id]
  end

  def set_chapter
    @chapter = Chapter.where(id: params[:id]).first
  end

  def set_chapters
    @chapters = @creation.chapters.all
  end

end
