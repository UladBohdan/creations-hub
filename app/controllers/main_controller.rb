class MainController < ApplicationController

  def index
    @creations = Creation.get_some_creations
    @most_rated = Creation.all.order(rating: :desc).limit(5)
    @most_recent = Creation.all.order(created_at: :desc).limit(5)
  end

  def admin

  end

end
