class Badge < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:title, :description]

  belongs_to :user

  class << self

    def check_badge(name, user)
      send "check_#{name}_badge", user, current_badge(name, user.id)
    end

    def check_commentator_badge(user, badge)
      5.downto(1) do |i|
        if user.comments.length+1 >= 5*i && i > badge.level
          params = {title: "commentator",
                    level: i,
                    description: "you have #{user.comments.length+1} comments under creations at the same time! Congrats!"}
          if badge.new_record?
            user.badges.create! params.merge(user_id: user.id)
          else
            badge.update! params.merge(user_id: user.id)
          end
          return params
        end
      end
      {}
    end

    def check_author_badge(user, badge)
      [15,10,5,2,1].each_with_index do |value, level|
        if user.creations.length >= value && 5-level > badge.level
          params = {title: "author",
                    level: 5-level,
                    description: "you have created #{user.creations.length} wonderful things! Thanks to your productivity!"}
          if badge.new_record?
            user.badges.create! params.merge(user_id: user.id)
          else
            badge.update! params.merge(user_id: user.id)
          end
          return params
        end
      end
      {}
    end

    def check_newbie_badge(user, badge)
      if badge.new_record?
        params = {title: "newbie",
                  level: 1,
                  description: "welcome! We want every user to have a badge. This one is for you!"}
        user.badges.create! params.merge(user_id: user.id)
        return params
      end
      {}
    end

    def check_polyglot_badge(user, badge)
      if badge.new_record?
        params = {title: "polyglot",
                  level: 1,
                  description: "wow! You've tried all our languages! No doubts - this badge is for you!"}
        user.badges.create! params.merge(user_id: user.id)
        return params
      end
      {}
    end

    def check_night_reader_badge(user, badge)
      if badge.new_record? && Time.now.hour.between?(0,5)
        params = {title: "night_reader",
                  level: 1,
                  description: "you love reading so much that you read even at night! That's great! We appreciate that!"}
        user.badges.create! params.merge(user_id: user.id)
        return params
      end
      {}
    end

    private

    def current_badge(name, user_id)
      Badge.where(user_id: user_id, title: name).first || Badge.new
    end

  end

end
