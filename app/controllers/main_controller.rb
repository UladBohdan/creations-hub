class MainController < ApplicationController

  def index
    @creations = Creation.get_some_creations
  end

  def login

  end

end
