class MainController < ApplicationController

  def index
    @creations = Creation.get_some_creations
  end

end
