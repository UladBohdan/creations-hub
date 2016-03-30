class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :creations
  has_many :comments
  has_many :chapters, :through => :creations
  has_many :badges
  has_many :ratings
  has_many :tags

  def self.get_full_info(id)
    includes(:comments).where(id: id).first
  end

end
