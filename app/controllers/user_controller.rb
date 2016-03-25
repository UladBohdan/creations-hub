class UserController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
    @creations = @user.creations.all
  end
end
