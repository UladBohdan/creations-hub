class Creation < ActiveRecord::Base
  extend EnumerateIt
  attr_accessor :category

  has_enumeration_for :category, with: Category

  belongs_to :user
  has_many :chapters

  def self.get_some_creations
    Creation.all
  end

end
