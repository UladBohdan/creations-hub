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

  end

end
