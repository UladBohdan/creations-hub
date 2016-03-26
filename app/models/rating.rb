class Rating < ActiveRecord::Base
  belongs_to :creation
  belongs_to :user

  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  class << self

    def get_average_rating(creation_id)
      rating = Rating.where(creation_id: creation_id)
      return 0 if rating.empty?
      rating.average(:value).to_i
    end

    def get_user_rating(user_id, creation_id)
      rating = Rating.where(user_id: user_id, creation_id: creation_id)
      return 0 if rating.empty?
      rating.first.value.to_i
    end

  end

end
