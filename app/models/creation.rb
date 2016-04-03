class Creation < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:title, :tags]

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
      filters = refactor_params filters
      all.set_category(filters[:category])
          .set_sort(filters[:sort])
          .set_limit(filters[:limit])
          .includes(:user, :comments, :chapters, :tags).preload(:ratings)
    end

    def refactor_params(filters)
      filters ||= {}
      default_filters = { limit: 6, category: "all", sort: "any" }
      filters.reverse_merge!(default_filters)
      filters[:sort] = "created_at" if filters[:sort] == "recently_created"
      filters[:sort] = "updated_at" if filters[:sort] == "recently_updated"
      filters[:limit] = 4 if filters[:limit] == "four"
      filters[:limit] = 6 if filters[:limit] == "six"
      filters[:limit] = 10 if filters[:limit] == "ten"
      filters
    end

    def set_category(category)
      (category == "all") ? all : where(category: Category.value_for(category.upcase))
    end

    def set_sort(sort)
      case sort
        when "most_rated"
          joins(:ratings).group("creations.id").order("AVG(ratings.value) DESC")
        when "created_at"
          order "created_at DESC"
        when "updated_at"
          order "updated_at DESC"
        else
          all
      end
    end

    def set_limit(limit)
      (limit == "no_limit") ? all : limit(limit)
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
