class ChapterController < ApplicationController
  before_action :set_creation, except: [:read, :destroy]
  before_action :set_chapters, only: [:index, :update, :reorder]
  before_action :set_chapter, only: [:read, :destroy]

  def create
    @creation.chapters << Chapter.create!(title: "Title for your new chapter!", text: "**Your new chapter text**", position: params[:position])
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

  def reorder
    ActiveRecord::Base.transaction do
      params[:new_order].each_with_index { |id, pos| Chapter.where(id: id).first.update(position: pos) }
    end
    render :json => {status: :ok}
  end

  def read
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @markdowned = markdown.render(@chapter.text)
  end

  def destroy
    @chapter.destroy!
    set_creation
    set_chapters
    render :json => @chapters.to_json
  end

  private

  def update_chapter_params
    params.require(:chapter).permit(:text, :title)
  end

  def set_creation
    @creation = Creation.get_creation_to_edit params[:creation_id]
  end

  def set_chapter
    @chapter = Chapter.where(id: params[:id]).first
  end

  def set_chapters
    @chapters = @creation.chapters
  end

end
