class UserController < ApplicationController
  def show
    @user = User.where(id: params[:id]).first
    @user_creations = @user.creations.all
  end
end
