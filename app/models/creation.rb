class Creation < ActiveRecord::Base
  extend EnumerateIt
  attr_accessor :category

  has_enumeration_for :category, with: Category

  belongs_to :user
  has_many :chapters

  validates :user_id, :title, presence: true

  class << self

    def get_creation(id)
      Creation.where(id: id).first
    end

    def get_some_creations
      Creation.all.limit(5)
    end

  end

end
