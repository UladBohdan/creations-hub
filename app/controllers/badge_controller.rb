class BadgeController < ApplicationController

  def check
    response = check_badge(params[:name])
    response.merge!(exists: !response.empty?)
    puts "RESPONSE #{response}"
    render :json => response.to_json
  end

end
