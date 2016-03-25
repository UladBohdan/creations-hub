class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation

  class << self

    def comments_for_creation(creation_id)
      Comment.includes(:user => [:name]).where(creation_id: creation_id).all
    end

  end

end
