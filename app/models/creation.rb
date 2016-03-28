class Creation < ActiveRecord::Base
  belongs_to :user
  has_many :chapters
  has_many :comments
  has_many :ratings

  validates :user_id, :title, presence: true

  def get_ordered_comments
    comments.order(created_at: :asc)
  end

  class << self

    def get_creation(id)
      Creation.includes(:chapters, :user, { comments: { likes: :user } }).where(id: id).first
    end

    def get_set_of_creations(filters)
      filters ||= {}
      default_filters = { limit: 6, category: "all", sort: "any" }
      filters.reverse_merge!(default_filters)
      filters[:sort] = "created_at" if filters[:sort] == "recently created"
      filters[:sort] = "updated_at" if filters[:sort] == "recently updated"
      creations = Creation.includes(:user, :ratings).all
      creations.where! category: Category.value_for(filters[:category].upcase) if filters[:category] != "all"
      if filters[:sort] == "most rated"
        #creations = creations.average("ratings.value", :includes => :ratings, order: "avg_ratings_value DESC")
        # how to search top-limit creations
        creations.limit!(filters[:limit]) if filters[:limit] != "no limit"
      elsif filters[:sort] != "any"
        creations.order!("#{filters[:sort]} DESC")
        creations.limit!(filters[:limit]) if filters[:limit] != "no limit"
      else
        return creations.sample(filters[:limit].to_i) if filters[:limit] != "no limit"
     end
      creations
    end

    def get_average_rating(creation_id)
      Rating.where(creation_id: creation_id).average(:value).to_i
    end

    def get_user_rating(user_id, creation_id)
      Rating.where(user_id: user_id, creation_id: creation_id).first.value.to_i
    end

  end

end
