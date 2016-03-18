class Creation < ActiveRecord::Base
  belongs_to :user
  has_many :chapters

  def self.get_some_creations
    Creation.all
  end

end
