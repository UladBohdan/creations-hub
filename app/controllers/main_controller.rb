class MainController < ApplicationController

  def index
    @creations = Creation.get_some_creations(nil)
  end

  def admin

  end

end
