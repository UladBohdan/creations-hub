class ChapterController < ApplicationController
  before_action :set_creation, except: [:read]
  before_action :set_chapters, only: [:index, :update, :reorder]
  before_action :set_chapter, only: [:destroy, :update]
  before_action :check_user, only: [:create, :update, :reorder, :destroy]

  def create
    @creation.chapters << Chapter.create!(title: "NEW", text: "<h1>Your new chapter text</h1>", position: params[:position])
    set_chapters
    render :json => @chapters.to_json
  end

  def index
    render :json => @chapters.to_json
  end

  def update
    @chapter.update(text: params[:text], title: params[:title])
    set_creation
    set_chapters
    render :json => @chapters.to_json
  end

  def reorder
    ActiveRecord::Base.transaction do
      params[:new_order].each_with_index { |id, pos| Chapter.where(id: id).first.update(position: pos+1) }
    end
    render :json => {status: :ok}
  end

  def read
    @chapter = Chapter.includes(creation: :chapters).where(id: params[:id]).first
    @creation = @chapter.creation
    sorted = sort_by_position(@creation.chapters)
    sorted.each_with_index do |chapter, i|
      if chapter.id == @chapter.id
        @prev_chapter = (i>0 ? sorted[i-1] : nil)
        @next_chapter = sorted[i+1]
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

  def check_user
    redirect_to root_url, alert: t("creation.no_rights_to_process") if cannot? :manage, @creation
  end

end
