class AddPositionToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :position, :integer, null: false, default: 0
  end
end
