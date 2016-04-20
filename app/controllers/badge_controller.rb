class BadgeController < ApplicationController

  def check
    response = check_badge(params[:name]) || {}
    response.merge!(exists: !response.empty?)
    render :json => response.to_json
  end

end
