class CreationController < ApplicationController

  def new
    current_user.creations << Creation.new
    redirect_to "/creation/#{current_user.creations.last.id}"
  end

  def show
    @creation = Creation.where(id: params[:id]).first
  end

end
