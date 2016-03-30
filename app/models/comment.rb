class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :creation
  has_many :likes, dependent: :destroy

  class << self

    def get_comment(id)
      Comment.includes(likes: :user).where(id: id).first
    end

    def get_comments_for_creation(creation_id)
      Comment.includes(:user, {likes: :user}).where(creation_id: creation_id).to_a
    end

  end

end
