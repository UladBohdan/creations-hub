class Creation < ActiveRecord::Base
  belongs_to :user
  has_many :chapters, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :tags, dependent: :destroy

  acts_as_taggable

  validates :user_id, :title, presence: true

  def get_ordered_comments
    comments.to_a.sort { |comment1, comment2| comment1.created_at <=> comment2.created_at }
  end

  def get_tags
    tags = []
    tag_list.to_a.each { |tag| tags << {text: tag} }
    tags
  end

  class << self

    def get_creation(id)
      Creation.includes(:chapters, :tags, {ratings: :user}, { comments: [:user, { likes: :user }] }).where(id: id).first
    end

    def get_creation_to_edit(id)
      Creation.includes(:chapters).where(id: id).first
    end

    def get_creation_with_comments(id)
      Creation.includes(comments: [:user, { likes: :user }]).where(id: id).first
    end

    def get_set_of_creations(filters)
      filters ||= {}
      default_filters = { limit: 6, category: "all", sort: "any" }
      filters.reverse_merge!(default_filters)
      filters[:sort] = "created_at" if filters[:sort] == "recently created"
      filters[:sort] = "updated_at" if filters[:sort] == "recently updated"
      creations = Creation.includes(:user, :ratings, :comments, :chapters, :tags).all
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

    def get_all_tags
      all_tags = []
      Creation.tag_counts_on(:tags).each { |tag| all_tags << { text: tag.name } }
      all_tags
    end

    def get_cloudy_tags
      all_tags = []
      Creation.tag_counts_on(:tags).each { |tag| all_tags << { text: tag.name, weight: tag.taggings_count } }
      all_tags.to_json
    end

  end

end
