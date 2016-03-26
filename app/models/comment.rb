class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation
  has_many :likes, dependent: :destroy

  class << self

    def comments_for_creation(creation_id)
      Comment.where(creation_id: creation_id).all
    end

  end

end
