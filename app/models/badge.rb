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
                    description: "you have #{5*i} comments under creations at the time! Congrats!"}
          if badge.nil?
            user.badges.create! params
          else
            badge.update! params
          end
          return
        end
      end
    end

    private

    def current_badge(name, user_id)
      Badge.where(user_id: user_id, title: name).first
    end

  end

end
