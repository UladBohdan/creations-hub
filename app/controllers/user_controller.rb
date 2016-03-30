class UserController < ApplicationController
  before_action :set_user
  before_action :set_creations
  before_action :set_badges

  def show
  end

  private

  def set_user
    @user = User.includes(creations: [:comments, :chapters, :tags, :ratings]).where(id: params[:id]).first
  end

  def set_creations
    @creations = @user.creations
  end

  def set_badges
    @badges = Badge.where(user_id: params[:id])
  end

end
