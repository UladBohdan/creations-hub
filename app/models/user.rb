class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :creations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :chapters, :through => :creations
  has_many :badges, dependent: :destroy
  has_many :ratings

end
