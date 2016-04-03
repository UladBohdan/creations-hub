class MainController < ApplicationController

  def index
    @creations = Creation.get_set_of_creations nil
  end

  def search
    found = PgSearch.multisearch(params[:query]).limit(6).to_a.map do |item|
      {type: item.searchable_type, content: item.content}
    end
    render :json => found.to_json
  end

end
