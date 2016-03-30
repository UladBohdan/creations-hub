class ChangeLevelColumnDefault < ActiveRecord::Migration
  def change
    change_column_default(:badges, :level, 0)
  end
end
