class MainController < ApplicationController

  def index
    @creations = Creation.get_set_of_creations nil
    @lang_changed = (params[:lang] == "true")
  end

  def search
    found = PgSearch.multisearch(params[:query]).includes(:searchable).limit(6).to_a.map do |item|
      send "#{item.searchable_type.downcase}_searchable", item.searchable
    end
    render :json => found.to_json
  end

  private

  def user_searchable(user)
    { type: "User", id: user.id, name: user.name, image: user.image }
  end

  def comment_searchable(comment)
    { type: "Comment", id: comment.id, creation_id: comment.creation_id, text: short_text(comment.text) }
  end

  def creation_searchable(creation)
    { type: "Creation", id: creation.id, title: creation.title }
  end

  def badge_searchable(badge)
    { type: "Badge", id: badge.id, title: badge.title, user_id: badge.user_id, level: badge.level, description: short_text(badge.description) }
  end

  def chapter_searchable(chapter)
    { type: "Chapter", id: chapter.id, title: chapter.title, text: short_text(chapter.text), creation_id: chapter.creation.id }
  end

  def short_text(text)
    text = ActionController::Base.helpers.strip_tags(text)
    if text.length < 200
      text
    else
      text[0, 200] + "..."
    end
  end

end
