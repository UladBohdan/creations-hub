class Chapter < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:text, :title]

  belongs_to :creation

  validates :title, :text, presence: true

end
