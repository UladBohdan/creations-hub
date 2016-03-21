class Chapter < ActiveRecord::Base
  belongs_to :creation

  validates :title, :text, presence: true

end
