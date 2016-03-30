class Badge < ActiveRecord::Base
  belongs_to :user

  class << self

    def check_badge(name, user)
      send "check_#{name}_badge", user, current_badge(name, user.id)
    end

    def check_commentator_badge(user, badge)
      5.downto(1) do |i|
        if user.comments.length >= 5*i && i > badge.level
          params = {title: "commentator",
                    level: i,
                    description: "you have #{user.comments.length} comments under creations at the same time! Congrats!"}
          if badge.nil?
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
        puts "AUTHOR #{value}  #{5-level}    badge #{badge.level}"
        if user.creations.length >= value && 5-level > badge.level
          params = {title: "author",
                    level: 5-level,
                    description: "you have created #{user.creations.length} wonderful things! Thanks to your productivity!"}
          if badge.nil?
            user.badges.create! params.merge(user_id: user.id)
          else
            badge.update! params.merge(user_id: user.id)
          end
          return params
        end
      end
      {}
    end

    private

    def current_badge(name, user_id)
      Badge.where(user_id: user_id, title: name).first || Badge.new
    end

  end

end
