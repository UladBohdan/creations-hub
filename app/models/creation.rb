class Creation < ActiveRecord::Base
  extend EnumerateIt
  attr_accessor :category

  has_enumeration_for :category, with: Category

  belongs_to :user
  has_many :chapters
  has_many :comments
  has_many :rating

  validates :user_id, :title, presence: true

  def get_ordered_comments
    comments.order(created_at: :asc)
  end

  class << self

    def get_creation(id)
      Creation.includes(:chapters, :user, { comments: { likes: :user } }).where(id: id).first
    end

    def get_some_creations(params)
      Creation.includes(:user, :rating).all.sample(6)
    end

    def get_average_rating(creation_id)
      Rating.where(creation_id: creation_id).average(:value).to_i
    end

    def get_user_rating(user_id, creation_id)
      Rating.where(user_id: user_id, creation_id: creation_id).first.value.to_i
    end

  end

end
