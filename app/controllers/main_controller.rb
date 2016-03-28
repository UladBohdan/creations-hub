class MainController < ApplicationController

  def index
    @creations = Creation.get_set_of_creations nil
  end

end
