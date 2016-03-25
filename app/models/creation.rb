class Creation < ActiveRecord::Base
  extend EnumerateIt
  attr_accessor :category

  has_enumeration_for :category, with: Category

  belongs_to :user
  has_many :chapters
  has_many :comments
  has_one :rating

  validates :user_id, :title, presence: true

  class << self

    def get_creation(id)
      Creation.where(id: id).first
    end

    def get_some_creations(params)
      Creation.includes(:user).all.sample(6)
    end

    def get_average_rating(creation_id)
      Rating.where(creation_id: creation_id).average(:value).to_i
    end

    def get_user_rating(user_id, creation_id)
      Rating.where(user_id: user_id, creation_id: creation_id).first.value.to_i
    end

  end

end
