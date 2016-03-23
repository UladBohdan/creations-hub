class RemoveRatingColumnFromCreations < ActiveRecord::Migration
  def change
    remove_column :creations, :rating
  end
end
