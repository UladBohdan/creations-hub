class ChapterController < ApplicationController
  before_action :set_creation, except: [:destroy, :read]
  before_action :set_chapters, only: [:index, :update, :reorder]
  before_action :set_chapter, only: [:read, :destroy]

  def create
    @creation.chapters << Chapter.create!(title: "NEW", text: "<h1>Your new chapter text</h1>", position: params[:position])
    set_chapters
    render :json => @chapters.to_json
  end

  def index
    render :json => @chapters.to_json
  end

  def update
    Chapter.where(id: params[:id]).first.update(text: params[:text], title: params[:title])
    set_creation
    set_chapters
    render :json => @chapters.to_json
  end

  def reorder
    ActiveRecord::Base.transaction do
      params[:new_order].each_with_index { |id, pos| Chapter.where(id: id).first.update(position: pos) }
    end
    render :json => {status: :ok}
  end

  def read
    puts "CHAPTER #{@chapter.id}"
    @creation = Creation.includes(:chapters).where(id: @chapter.creation_id).first
    puts "CREATION #{@creation.id}"
    @creation.chapters.sort_by { |chapter| chapter.position }
    @creation.chapters.each_with_index do |chapter, i|
      if chapter.id == @chapter.id
        @prev_chapter = @creation.chapters[i-1]
        @next_chapter = @creation.chapters[i+1]
      end
    end
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
    @chapter = Chapter.includes(:creation).where(id: params[:id]).first
  end

  def set_chapters
    @chapters = @creation.chapters
  end

end
